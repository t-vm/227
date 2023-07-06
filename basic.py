import tkinter as tk
from tkinter import filedialog

def open_file(text):
    file_path = filedialog.askopenfilename()
    if file_path:
        with open(file_path, 'r') as f:
            text.delete('1.0', tk.END)
            text.insert(tk.END, f.read())
        
def translate():
    pass

def master_vocabulary_book():
    pass

def not_master_vocabulary_book():
    pass