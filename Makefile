# Start a bash shell with a clean environment
start:
	@env -i bash --noprofile --rcfile core/home/.bashrc

start-docker:
	@./scripts/start_docker.sh

test:
	@./scripts/run-tests.sh
