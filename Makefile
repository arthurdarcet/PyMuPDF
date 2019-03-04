all: _osx _linux _upload

build:
	swig -python fitz/fitz.i

_osx:
	python setup.py build
	pip install wheel
	python setup.py bdist_wheel

_linux:
	docker run --rm -v `pwd`:/app python:3.7 /app/build-linux.sh

_upload:
	pip install twine
	twine upload -r glose