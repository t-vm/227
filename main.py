import tkinter as tk
import basic

class Application(tk.Frame):
    def __init__(self, master=None):
        super().__init__(master)
        self.master = master
        self.pack()
        self.create_widgets()

    def create_widgets(self):
        
        self.top_frame = tk.Frame(self)
        self.top_frame.pack()
        
        self.bottom_frame = tk.Frame(self)
        self.bottom_frame.pack()
        
        self.left_frame = tk.Frame(self.top_frame)
        self.left_frame.pack(side=tk.LEFT)

        self.right_frame = tk.Frame(self.top_frame)
        self.right_frame.pack(side=tk.RIGHT)
        
        self.passage_text = tk.Text(self.left_frame, height=50, width=150)
        self.passage_text.pack()

        self.word_text = tk.Text(self.right_frame, height=50, width=50)
        self.word_text.pack()
        
        self.open_button = tk.Button(self.bottom_frame)
        self.open_button["text"] = "打开文件"
        self.open_button["command"] = lambda: basic.open_file(self.passage_text)
        self.open_button.pack(side=tk.LEFT)

        self.save_button = tk.Button(self.bottom_frame)
        self.save_button["text"] = "翻译"
        self.save_button["command"] = basic.translate()
        self.save_button.pack(side=tk.LEFT)
        
        self.master_button = tk.Button(self.bottom_frame)
        self.master_button["text"] = "未掌握单词本"
        self.master_button["command"] = basic.not_master_vocabulary_book()
        self.master_button.pack(side=tk.LEFT)
        
        self.not_master_button = tk.Button(self.bottom_frame)
        self.not_master_button["text"] = "已掌握单词本"
        self.not_master_button["command"] = basic.master_vocabulary_book()
        self.not_master_button.pack(side=tk.LEFT)

        self.quit_button = tk.Button(self.bottom_frame, text="退出", command=self.master.destroy)
        self.quit_button.pack(side=tk.LEFT)

root = tk.Tk()
app = Application(master=root)
app.mainloop()
