import re
import tkinter as tk
from tkinter import filedialog
import requests
import json
 
passage_file_path = None
book_file_path = None

def get_word_definitions(word):
    url = f'https://api.dictionaryapi.dev/api/v2/entries/en/{word}'
    response = requests.get(url)
    if response.status_code == 200:
        data = json.loads(response.text)
        return data
    else:
        return None

def get_set(file_path):            
    with open(file_path, 'r') as f:
        content = f.read()
        words = re.findall(r'\b\w+\b', content.lower())
        return set(words)

def open_file(text):
    global passage_file_path
    passage_file_path = filedialog.askopenfilename()
    if passage_file_path:
        with open(passage_file_path, 'r') as f:
            text.delete('1.0', tk.END)
            text.insert(tk.END, f.read())
        
def translate():
    if not passage_file_path:
        return
    translate_word_set = get_set(passage_file_path) - get_set('master_word.txt')
    
    
    
    update_not_master_word_set = get_set('not_master_word.txt') | translate_word_set
    update_not_master_word_set_str = ' '.join(sorted(update_not_master_word_set))
    with open('not_master_word.txt', 'w') as f:
        f.write(update_not_master_word_set_str)
    
def master_vocabulary_book(text):
    global book_file_path
    book_file_path = 'master_word.txt'
    with open(book_file_path, 'r') as f:
        text.delete('1.0', tk.END)
        text.insert(tk.END, f.read())

def not_master_vocabulary_book(text):
    global book_file_path
    book_file_path = 'not_master_word.txt'
    with open(book_file_path, 'r') as f:
        text.delete('1.0', tk.END)
        text.insert(tk.END, f.read())

def save_file(text):
    if not book_file_path:
        return
    
    origin_content = get_set(book_file_path)
    with open(book_file_path, 'w') as f:
        f.write(text.get('1.0', tk.END))
    new_content = get_set(book_file_path)
    
    if origin_content == new_content:
        return
    reduce_word_set = origin_content - new_content
    add_word_set = new_content - origin_content

    other_book_file_path = 'master_word.txt' if book_file_path == 'not_master_word.txt' else 'not_master_word.txt'
    other_word_set = get_set(other_book_file_path)
    other_word_set |= reduce_word_set
    other_word_set -= add_word_set
    other_word_str = ' '.join(sorted(other_word_set))
    with open(other_book_file_path, 'w') as f:
        f.write(other_word_str)
    