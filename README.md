# library
An open-source library webapp written in Django

## Pre-requisites

1. Install `docker`

## Setting up dev environment

1. Create a [virtual environment](https://realpython.com/python-virtual-environments-a-primer/): `python -m venv .venv`
2. Activate virtual environment: `source .venv/bin/activate`
3. Install python third-party packages: `pip install -r py-requirements/local.txt`
4. Change directory to `library_project`
5. Create `.env` file by copying `.env.sample` and fill-in the missing values
6. Run `docker compose up`
