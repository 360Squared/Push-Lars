import queue

class ProducerConsumer():                   # Producer Consumer pattern.
    callback_queue = queue.Queue()

    @staticmethod
    def produce(song_name):                   # Add something to the queue.         
        ProducerConsumer.callback_queue.put(song_name)

    @staticmethod
    def consume():                   # Get something from the queue and remove it.
        try:
            return ProducerConsumer.callback_queue.get(False)
        except queue.Empty:
            return ""