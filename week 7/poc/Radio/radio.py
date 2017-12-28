import threading

from mpd import MPDClient

from producerconsumer import ProducerConsumer

class Radio():

    def __init__(self):
        self.client = MPDClient()               # create client object
        self.client.timeout = None              # network timeout in seconds (floats allowed), default: None
        self.client.idletimeout = None          # timeout for fetching the result of the idle command is handled seperately, default: None
        self.client.connect("localhost", 6600)  # connect to localhost:6600
        t = threading.Thread(name="current song", target=self.get_current_song, daemon=True) # Initialize a new thread.
        t.start()                               # Start the current thread.

    def play_pause(self, play):                 # Start or stop playing the music.
        if play:
            self.client.play(0)
        else:
            self.client.stop()    

    def set_volume(self, volume):               # Increase or decrease the volume of the music server.
        self.client.setvol(volume)

    def get_status(self):                       # Get current volume and state of the server used only during start up of the application.
        status = self.client.status()
        #return int(status["volume"])
        return {"volume": status["volume"], "state":status["state"]}

    def get_current_song(self):               # Used in the new thread. Had to make a new client, otherwise I couldn't get the current playing song, since im waiting for a change.
        client = MPDClient() 
        client.timeout = None
        client.idletimeout = None
        client.connect("localhost", 6600)
        while client.idle("playlist"):
            ProducerConsumer.produce(song_name=self.get_song_name())
            print(self.get_song_name())

    def get_song_name(self):                   # Get the current song name, only used during start up and when switching radio stations.
        song = self.client.currentsong()
        if "title" in song:
            return song["title"]
        else:
            return "Unknown - Unknown"

    def previous_next(self, next):          # Switching playlists.
        if next:
            self.client.next()
        else:
            self.client.previous()