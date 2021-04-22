FROM ubuntu:latest

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        git \
        curl \
        vim \
        wget \
        build-essential \
        gcc \
        make \
        cmake \
        cmake-gui \
        cmake-curses-gui \
        libssl-dev \
        libbluetooth-dev \
        usbutils \
        bluez

RUN git clone https://github.com/eclipse/paho.mqtt.c.git \
    && cd paho.mqtt.c \
    && make \
    && make install

COPY . bluetooth-temperature-sensors

RUN cd bluetooth-temperature-sensors \
    gcc -o ble_sensor_mqtt_pub ble_sensor_mqtt_pub.c -lbluetooth -l paho-mqtt3c
