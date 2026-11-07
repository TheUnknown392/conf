#!/usr/bin/env bash

echo "Installing Services..."
sudo cp ../scripts/service/battery-charge-threshold.service /etc/systemd/system;

sudo systemctl daemon-reload;
sudo systemctl enable battery-charge-threshold.service;
sudo systemctl start battery-charge-threshold.service;

