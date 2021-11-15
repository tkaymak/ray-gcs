set -x

fail_count=0
max_counts=5
check_interval_s=5

main_loop() {
    while true; do
        sleep ${check_interval_s}

        # Check ray health, if not healthy, crash the ray clsuter to trigger a restart
        if /home/ray/anaconda3/bin/ray health-check
        then
            echo "Ray healthy"
        else
            ((fail_count++))
        fi

        # Check Serve health, if not healthy, crash the ray cluster and redeploy
        # TODO: change this to your application specific routes
        if curl localhost:8000/-/routes
        then
            echo "Serve healthy"
        else
            ((fail_count++))
        fi

        if [[ $fail_count == $max_counts ]]; then
            echo "Stopping Ray due to failed health checks"
            /home/ray/anaconda3/bin/ray stop --force
            exit 1
        fi
    done
}

# Give it sometime for Ray processes to startup.
sleep ${check_interval_s}

# Start Serve
/home/ray/anaconda3/bin/serve \
  start \
  --checkpoint-path="custom://ray_gcs.RayGcsKVStore?bucket=di_ray&prefix=v2" \
  --http-location=EveryNode \
  --http-host=0.0.0.0

# Give it sometime for Ray Serve to startup
sleep ${check_interval_s}

main_loop

