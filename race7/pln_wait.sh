#!/bin/bash

executeScript() {
    echo "Parking Lot Nerds, waiting to start";
    read -p 'start racing: ' value;
    echo $value;
    python3 /root/race7/manage.py drive --model=/root/race7/models/warren_pln5.h5
}
executeScript