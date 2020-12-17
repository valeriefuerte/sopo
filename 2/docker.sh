docker build -t ansible .
docker run --volume sopo:/sopo ansible ls -la
