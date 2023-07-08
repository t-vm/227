import re
import tkinter as tk
from tkinter import filedialog
            
def get_set(file_path):            
    with open(file_path, 'r') as f:
        content = f.read()
        words = re.findall(r'\b\w+\b', content.lower())
        return set(words)

def open_file(text):
    file_path = filedialog.askopenfilename()
    if file_path:
        with open(file_path, 'r') as f:
            text.delete('1.0', tk.END)
            text.insert(tk.END, f.read())
        
def translate():
    pass

def master_vocabulary_book(text):
    global file_path
    file_path = 'master_word.txt'
    with open(file_path, 'r') as f:
        text.delete('1.0', tk.END)
        text.insert(tk.END, f.read())

def not_master_vocabulary_book(text):
    global file_path
    file_path = 'not_master_word.txt'
    with open(file_path, 'r') as f:
        text.delete('1.0', tk.END)
        text.insert(tk.END, f.read())

def save_file(text):
    if not file_path:
        return
    
    origin_content = get_set(file_path)
    with open(file_path, 'w') as f:
        f.write(text.get('1.0', tk.END))
    new_content = get_set(file_path)
    
    if origin_content == new_content:
        return
    reduce_word_set = origin_content - new_content
    add_word_set = new_content - origin_content
    
    other_file_path = 'master_word.txt' if file_path == 'not_master_word.txt' else 'not_master_word.txt'
    other_word_set = get_set(other_file_path)
    other_word_set |= reduce_word_set
    other_word_set -= add_word_set
    other_word_str = ' '.join(sorted(other_word_set))
    with open(other_file_path, 'w') as f:
        f.write(other_word_str)
