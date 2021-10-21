from setuptools import find_packages, setup

with open("README.md", "r", encoding="utf-8") as fh:
        long_description = fh.read()

setuptools.setup(
    name='ray-gcs',
    version='0.0.3',
    author='Tobias Kaymak',
    author_email='tobias.kaymak@gmail.com',
    description='Ray KV GCS addon',
    long_description=long_description,
    long_description_content_type="text/markdown",
    url='https://github.com/tkaymak/ray_gcs',
    license='MIT',
    package_dir={"": "src"},
    packages=find_packages('src'),
    install_requires=['ray', 'google-cloud-storage'],
)
