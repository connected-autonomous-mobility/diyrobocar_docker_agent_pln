import json
import time
import logging

from gym_donkeycar.core.sim_client import SDClient



###########################################

class PrivateAPIClient(SDClient):

    def __init__(self, address, private_key, poll_socket_sleep_time=0.01):
        super().__init__(*address, poll_socket_sleep_time=poll_socket_sleep_time)

        self.private_key = private_key
        self.is_verified = False
        self.last_time = time.time()
        self.laptime = 0.0
        self.lapcount = 0
        self.firsttime = True

    def on_msg_recv(self, json_packet):
        msg_type = json_packet.get('msg_type')
        if msg_type == 'verified':
            self.is_verified = True
            print(json_packet)
        if msg_type == 'collision_with_starting_line':
            self.laptime = json_packet['timeStamp'] - self.last_time
            self.last_time = json_packet['timeStamp']
            if self.firsttime:
                print("starting race...")
                self.firsttime = False
            else:
                self.lapcount += 1
                print(json_packet['car_name'], " lap(s): ",self.lapcount, "   time(s): ", self.laptime)

    def send_verify(self):
        msg = {"msg_type": "verify",
               "private_key": str(self.private_key)}
        self.send_now(json.dumps(msg))

    def send_seed(self, seed):
        msg = {"msg_type": "set_random_seed",
               "seed": str(seed)}
        self.send_now(json.dumps(msg))


def test_clients():
    logging.basicConfig(level=logging.DEBUG)

    # test params
    host = "127.0.0.1"
    #host= "donkey-sim.roboticist.dev"
    port = 9092
    private_key = "45700600"  # please enter your private key (provided in the menu of the simulator)

    client = PrivateAPIClient((host, port), private_key)
    client.send_verify()

    time.sleep(0.2)  # wait for the response of the server
    print(f"is the client verified ? {client.is_verified}")

    client.send_seed(42)  # try to set the seed used for the challenges


if __name__ == "__main__":
    test_clients()