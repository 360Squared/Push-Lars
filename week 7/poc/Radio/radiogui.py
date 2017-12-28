import tkinter
from tkinter import PhotoImage

from producerconsumer import ProducerConsumer
from radio import Radio

class RadioGui(tkinter.Tk):

    def __init__(self,parent):
        tkinter.Tk.__init__(self,parent)
        self.volume = tkinter.IntVar()
        self.author = tkinter.StringVar()
        self.song_name = tkinter.StringVar()

        self.radio = Radio()
        statts = self.radio.get_status()
        self.volume.set(int(statts["volume"]))
        if statts["state"] == "pause":
            self.pause = False
        elif statts["state"] == "play":
            self.pause = True
        elif statts["state"] == "stop":
            self.pause= True

        self.parent = parent
        self.play_pause_button = tkinter.Button(self, command=self.play_pause)
        self.initialize()

    def initialize(self):
        self.grid()
        self.play_pause_button.grid(column=0,row=2)
        image = PhotoImage(file="img/"+ str(self.pause)+ ".gif")
        self.play_pause_button.config(image=image)
        self.play_pause_button.image = image

        self.add_button(column=1, row=2, imageFile="up-button.gif", function=lambda: self.set_volume(+1), delay=1, interval=100)
        self.add_button(column=2, row=2, imageFile="down-button.gif", function=lambda: self.set_volume(-1), delay=1, interval=100)
        self.add_button(column=3, row=2, imageFile="previous-button.gif", function=lambda: self.previous_next(False))
        self.add_button(column=4, row=2, imageFile="next-button.gif", function=lambda: self.previous_next(True))
        self.add_button(column=5, row=2, imageFile="list-of-files.gif", function=lambda: None)
        label = tkinter.Label(self, textvariable=self.song_name, anchor="w", fg="white", bg="blue")
        label.grid(column=2, row=0, columnspan=2, sticky='EW')
        
        label = tkinter.Label(self, textvariable=self.author, anchor="w", fg="white", bg="red")
        label.grid(column=2, row=1, columnspan=2, sticky='EW')

        label = tkinter.Label(self, textvariable=self.volume, anchor="w", fg="white", bg="black")
        label.grid(column=4, row=0, sticky='EW')
        self.play_pause()
        string = self.radio.get_song_name().split(" - ", 1)
        self.author.set(string[0])
        self.song_name.set(string[1])

    def previous_next(self, next):
        if self.pause:
            return
        else:
            self.radio.previous_next(next)

    def update_song_name(self):                   # Get something from the Queue updates the song and authtor when it can.
        string = ProducerConsumer.consume()
        if string == "":
            return

        song_data = string.split(" - ", 1)
        self.author.set(song_data[0])
        self.song_name.set(song_data[1])

    def add_button(self, column, row, imageFile, function, delay=None, interval=None):                   # Adds the buttons
        button = tkinter.Button(self, command=function, repeatdelay=delay, repeatinterval=interval)
        button.grid(column=column,row=row)
        image = PhotoImage(file="img/"+imageFile)
        button.config(image=image)
        button.image = image

    def play_pause(self):                   # Start or stop the music / updates the button icons show a play/pause button. 
        self.radio.play_pause(self.pause)
        self.pause = not self.pause
        image = PhotoImage(file="img/"+str(self.pause)+".gif")
        self.play_pause_button.config(image=image)
        self.play_pause_button.image = image
        

    def set_volume(self, vol):                   # Sets the volume.
        if self.volume.get() >= 100 or self.volume.get() <= 0:
            return
        else:
            self.volume.set(self.volume.get() + vol)

        self.radio.set_volume(self.volume.get())