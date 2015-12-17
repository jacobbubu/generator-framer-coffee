Framer.Device = new Framer.DeviceView()
Framer.Device.deviceType = 'iphone-6-gold-hand'
Framer.Device.setupContext()

# Welcome to Framer
# This is just demo code. Feel free to delete it all.

imageLayer = new Layer
    x: 0
    y: 0
    width: 128
    height: 128
    image: 'images/Icon.png'

imageLayer.center()

# Define a set of states with names (the original state is 'default')
states = JSON.parse Utils.domLoadDataSync "data/states.json"

for i in [0...states.length]
    imageLayer.states.add "State#{i}": states[i]

# Set the default animation options
imageLayer.states.animationOptions = curve: 'spring(500,12,0)'

# On a click, go to the next state
imageLayer.on Events.Click, -> imageLayer.states.next()

hint = require('./modules/hint')()

textLayer = new Layer
    x: 0
    y: Screen.height - 96
    width: Screen.width
    height: 64
    backgroundColor: 'none'
    color: 'white'
    html: """
        <p style="text-align: center; font-size: 48px; line-height: 1.2">#{hint}</p>
    """

textLayer.centerX()