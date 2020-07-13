# SS Docker Example

Keeping the BASH history in Docker and sending messages to a cellphone.

### Installation

0. Change the Telegram credentials of the telegram-send.conf file

1. Clone this repository
  	```bash
  	git clone --recursive https://github.com/gorayni/ss.git
  	```

2. Build the Docker image. For the GPU Tensorflow version use the following command:
	```bash
	docker build -t ss_gpu:1.0 dockerfile
	```

	For the CPU Tensorflow version use:
	```bash
	docker build --build-arg IMG_TAG=intelaipg/intel-optimized-tensorflow:latest-devel-mkl-py3 \
	-t ss_cpu:1.0 dockerfile
	```

3. Run the Docker image like

	```bash
	./scripts/run_docker.sh
	```

   or with CPU

	```bash
	./scripts/run_docker.sh 0 cpu
	```

4. Once inside Docker you can check the BASH history with CTRL+R.

5. Run the fake training example by typing

	```bash
	./scripts/train_cnn.sh conf/fake.json
	```
   
   This will create a log file and send notifications to your Telegram chat.
