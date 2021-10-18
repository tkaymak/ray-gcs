from setuptools import find_packages, setup

setuptools.setup(
    name='ray-gcs',
    version='0.0.1',
    author='Tobias Kaymak',
    author_email='tobias.kaymak@gmail.com',
    description='Ray KV GCS addon',
    long_description=long_description,
    long_description_content_type="text/markdown",
    url='https://github.com/tkaymak/ray_gcs',
    license='MIT',
    packages=find_packages('ray_gcs'),
    install_requires=['ray', 'google-cloud-storage'],
)
