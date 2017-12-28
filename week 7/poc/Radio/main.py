import time

from radiogui import RadioGui

if __name__ == "__main__":
    app = RadioGui(None)
    app.title('Python Ethernet Radio')
    while True:
        app.update_idletasks()
        app.update()
        app.update_song_name()
        time.sleep(1)