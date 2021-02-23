
from donkeycar.parts.controller import Joystick, JoystickController


class MyJoystick(Joystick):
    #An interface to a physical joystick available at /dev/input/js0
    def __init__(self, *args, **kwargs):
        super(MyJoystick, self).__init__(*args, **kwargs)

            
        self.button_names = {
            0x122 : 'x',
            0x127 : 'menue',
            0x123 : 'y',
            0x120 : 'a',
            0x121 : 'b',
            0x129 : 'lsb',
            0x128 : 'rsb',
            0x12a : 'xlower',
            0x126 : 'listright',
        }


        self.axis_names = {
            0x0 : 'steering',
            0x1 : 'throttle',
            0x2 : 'brake',
        }



class MyJoystickController(JoystickController):
    #A Controller object that maps inputs to actions
    def __init__(self, *args, **kwargs):
        super(MyJoystickController, self).__init__(*args, **kwargs)


    def init_js(self):
        #attempt to init joystick
        try:
            self.js = MyJoystick(self.dev_fn)
            self.js.init()
        except FileNotFoundError:
            print(self.dev_fn, "not found.")
            self.js = None
        return self.js is not None


    def init_trigger_maps(self):
        #init set of mapping from buttons to function calls
            
        self.button_down_trigger_map = {
        }


        self.axis_trigger_map = {
            'steering' : self.set_steering,
            'throttle' : self.set_throttle,
        }


