import tkinter as tk
from tkinter import filedialog

def open_file():
    file_path = filedialog.askopenfilename()
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.read()

def display_file_content(file_content):
    text.delete('1.0', tk.END)
    text.insert(tk.END, file_content)

def get_file_words(file_content):
    pass

root = tk.Tk()

frame = tk.Frame(root)
frame.pack(side=tk.BOTTOM)

button = tk.Button(frame, text='打开文件', command=lambda: display_file_content(open_file()))
button.pack(side=tk.LEFT)

words_button = tk.Button(frame, text='生词翻译', command=lambda: get_file_words(text.get('1.0', tk.END)))
words_button.pack(side=tk.LEFT)

text = tk.Text(root)
text.pack()

root.mainloop()