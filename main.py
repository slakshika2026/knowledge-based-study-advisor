
import tkinter as tk
from tkinter import ttk, scrolledtext, font as tkfont
import subprocess
import threading

def run_prolog_thread():
    try:
        q1 = "yes" if var1.get() else "no"
        q2 = "yes" if var2.get() else "no"
        q3 = "yes" if var3.get() else "no"
        q4 = combo4.get().lower()
        q5_raw = combo5.get()
        q6_raw = combo6.get()
        q7_raw = combo7.get()
        q8_raw = combo8.get()
        q9_raw = combo9.get().lower()
        q10 = "yes" if var10.get() else "no"

        focus_map = {"<30 min": "<30_min", "30–60 min": "30-60_min", ">60 min": ">60_min"}
        q5 = focus_map[q5_raw]

        sound_map = {
            "Complete silence": "complete_silence",
            "Minimal sound": "minimal_sound",
            "Instrumental": "instrumental",
            "Songs with lyrics": "lyrics",
            "White noise": "white_noise"
        }
        q6 = sound_map[q6_raw]

        group_map = {"Alone": "alone", "1 friend": "one_friend", "2–3 friends": "small_group"}
        q7 = group_map[q7_raw]

        location_map = {"Fixed desk": "fixed", "Move around": "move_around"}
        q8 = location_map[q8_raw]

        with open("facts.pl", "w", encoding="utf-8") as f:
            f.write(f"draws_diagrams({q1}).\n")
            f.write(f"explains_aloud({q2}).\n")
            f.write(f"needs_practice({q3}).\n")
            f.write(f"energy_peak({q4}).\n")
            f.write(f"focus_span('{q5}').\n")
            f.write(f"sound_preference({q6}).\n")
            f.write(f"group_size({q7}).\n")
            f.write(f"study_location({q8}).\n")
            f.write(f"exam_priority({q9_raw}).\n")
            f.write(f"time_pressure_panic({q10}).\n")

        result = subprocess.run([
            "swipl", "-q", "-s", "prolog_kb.pl",
            "-g", "consult('facts.pl'), generate_plan, halt"
        ], capture_output=True, text=True, encoding='utf-8', timeout=10)

        def format_output(raw_output):
            """Format Prolog output with clean professional styling"""
            lines = raw_output.split('\n')
            
            for line in lines:
                # Skip box borders and decorative elements
                if '╔' in line or '╚' in line or '║' in line:
                    continue
                    
                # Skip separator lines
                if line.strip().startswith('─'):
                    text_result.insert(tk.END, '\n')
                    continue
                
                # Section headers (with emojis - remove emojis)
                if any(emoji in line for emoji in ['📚', '🌍', '📋', '🎯', '🛠️', '🎓', '💡']):
                    # Remove emoji and clean up text
                    clean_line = line
                    for emoji in ['📚', '🌍', '📋', '🎯', '🛠️', '🎓', '💡']:
                        clean_line = clean_line.replace(emoji, '').strip()
                    if clean_line:
                        text_result.insert(tk.END, clean_line.upper() + '\n', 'section_header')
                    continue
                
                # Bullet points - remove checkmark emoji
                if line.strip().startswith('✓'):
                    clean_line = line.replace('✓', '•').strip()
                    text_result.insert(tk.END, '  ' + clean_line + '\n', 'bullet')
                    continue
                
                # Key-value pairs (labels and values)
                if ':' in line and '   ' in line:
                    parts = line.split(':', 1)
                    if len(parts) == 2:
                        label = parts[0].strip()
                        value = parts[1].strip()
                        if label and value:
                            text_result.insert(tk.END, '  ' + label + ': ', 'label')
                            text_result.insert(tk.END, value + '\n', 'value')
                        continue
                
                # Regular text - skip empty lines
                if line.strip():
                    text_result.insert(tk.END, line + '\n')

        def update_gui():
            if not text_result.winfo_exists():
                return
            text_result.config(state='normal')
            text_result.delete('1.0', tk.END)
            
            if result.returncode != 0:
                text_result.insert('1.0', f"ERROR: Unable to generate plan\n\n{result.stderr}", 'error')
            elif result.stdout.strip():
                format_output(result.stdout)
            else:
                text_result.insert('1.0', "No output generated. Please try again.", 'error')
            
            text_result.see('1.0')
            text_result.config(state='disabled')
            btn_generate.config(state='normal', text="Generate Study Plan")
        
        root.after(0, update_gui)
        
    except Exception as e:
        def show_error():
            text_result.config(state='normal')
            text_result.delete('1.0', tk.END)
            text_result.insert('1.0', f"ERROR: {e}", 'error')
            text_result.config(state='disabled')
            btn_generate.config(state='normal', text="Generate Study Plan")
        root.after(0, show_error)

def run_prolog():
    btn_generate.config(state='disabled', text="Generating...")
    text_result.config(state='normal')
    text_result.delete('1.0', tk.END)
    text_result.insert('1.0', "Generating your personalized study plan...\n\nPlease wait...", 'loading')
    text_result.config(state='disabled')
    threading.Thread(target=run_prolog_thread, daemon=True).start()

# === OPTIMIZED FULL-SCREEN DESIGN ===
root = tk.Tk()
root.title("Study Fit Advisor")
root.state('zoomed')  # Maximize window
root.configure(bg="#ffffff")

# Bold Black & Gold theme
BG = "#ffffff"
CARD_BG = "#fafafa"
ACCENT = "#ffc300"  # Gold
ACCENT_HOVER = "#ffb700"  # Darker gold
ACCENT_DARK = "#e6b000"
SUCCESS = "#ffc300"  # Gold for bullets
TEXT_PRIMARY = "#000000"  # Black
TEXT_SECONDARY = "#333333"  # Dark gray
BORDER = "#e0e0e0"
RESULT_BG = "#ffffff"

# Professional fonts - Poppins & Montserrat
# Check if custom fonts are available, fallback to system fonts
available_fonts = tkfont.families()
if "Poppins" in available_fonts:
    TITLE_FONT = ("Poppins", 22, "bold")
    BUTTON_FONT = ("Poppins", 10, "bold")
else:
    TITLE_FONT = ("Arial", 22, "bold")
    BUTTON_FONT = ("Arial", 10, "bold")

if "Montserrat" in available_fonts:
    SUBTITLE_FONT = ("Montserrat", 9)
    LABEL_FONT = ("Montserrat", 9)
    RESULT_FONT = ("Montserrat", 9)
    SECTION_FONT = ("Montserrat", 11, "bold")
    VALUE_FONT = ("Montserrat", 9, "bold")
else:
    SUBTITLE_FONT = ("Segoe UI", 9)
    LABEL_FONT = ("Segoe UI", 9)
    RESULT_FONT = ("Segoe UI", 9)
    SECTION_FONT = ("Segoe UI", 11, "bold")
    VALUE_FONT = ("Segoe UI", 9, "bold")

# Custom ttk style
style = ttk.Style()
style.theme_use('clam')
style.configure('Custom.TCombobox', 
                fieldbackground=CARD_BG,
                background=CARD_BG,
                borderwidth=1,
                arrowcolor=TEXT_PRIMARY,
                foreground=TEXT_PRIMARY,
                padding=4)
style.map('Custom.TCombobox',
          fieldbackground=[('readonly', CARD_BG)],
          foreground=[('readonly', TEXT_PRIMARY)])

# Main container with minimal padding
main = tk.Frame(root, bg=BG)
main.pack(fill="both", expand=True, padx=20, pady=15)

# Compact header
header = tk.Frame(main, bg=BG)
header.pack(fill="x", pady=(0, 12))
tk.Label(header, text="Study Fit Advisor", font=TITLE_FONT, 
         bg=BG, fg=TEXT_PRIMARY).pack(anchor="w")
tk.Label(header, text="Discover your personalized learning strategy", 
         font=SUBTITLE_FONT, bg=BG, fg=TEXT_SECONDARY).pack(anchor="w", pady=(2, 0))

# Content area - side by side
content = tk.Frame(main, bg=BG)
content.pack(fill="both", expand=True)

# LEFT: Questions in grid layout (no scrolling needed)
left = tk.Frame(content, bg=CARD_BG, highlightbackground=BORDER, highlightthickness=1)
left.pack(side="left", fill="both", expand=True, padx=(0, 12))

# Questions container
q_container = tk.Frame(left, bg=CARD_BG)
q_container.pack(fill="both", expand=True, padx=15, pady=12)

# Compact question layout
def add_compact_question(parent, row, col, num, text, colspan=1):
    frame = tk.Frame(parent, bg=CARD_BG)
    frame.grid(row=row, column=col, columnspan=colspan, sticky="ew", padx=6, pady=4)
    tk.Label(frame, text=f"{num}. {text}", font=LABEL_FONT, bg=CARD_BG, 
             fg=TEXT_PRIMARY, wraplength=280, justify="left", anchor="w").pack(fill="x")
    return frame

# Configure grid columns
q_container.columnconfigure(0, weight=1)
q_container.columnconfigure(1, weight=1)

# Row 0: Q1 | Q2
q1_frame = add_compact_question(q_container, 0, 0, 1, "Do you remember concepts better when you draw diagrams or mind maps?")
var1 = tk.BooleanVar()
btn_frame1 = tk.Frame(q1_frame, bg=CARD_BG)
btn_frame1.pack(anchor="w", pady=(2, 0))
tk.Radiobutton(btn_frame1, text="Yes", variable=var1, value=True, bg=CARD_BG, 
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left", padx=(0, 10))
tk.Radiobutton(btn_frame1, text="No", variable=var1, value=False, bg=CARD_BG, 
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left")

q2_frame = add_compact_question(q_container, 0, 1, 2, "Do you understand better when you explain the topic aloud to yourself or a friend?")
var2 = tk.BooleanVar()
btn_frame2 = tk.Frame(q2_frame, bg=CARD_BG)
btn_frame2.pack(anchor="w", pady=(2, 0))
tk.Radiobutton(btn_frame2, text="Yes", variable=var2, value=True, bg=CARD_BG,
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left", padx=(0, 10))
tk.Radiobutton(btn_frame2, text="No", variable=var2, value=False, bg=CARD_BG,
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left")

# Row 1: Q3 | Q4
q3_frame = add_compact_question(q_container, 1, 0, 3, "Do you need to solve practice problems to feel ready?")
var3 = tk.BooleanVar()
btn_frame3 = tk.Frame(q3_frame, bg=CARD_BG)
btn_frame3.pack(anchor="w", pady=(2, 0))
tk.Radiobutton(btn_frame3, text="Yes", variable=var3, value=True, bg=CARD_BG,
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left", padx=(0, 10))
tk.Radiobutton(btn_frame3, text="No", variable=var3, value=False, bg=CARD_BG,
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left")

q4_frame = add_compact_question(q_container, 1, 1, 4, "At what time of day do you usually feel most active and focused?")
combo4 = ttk.Combobox(q4_frame, values=["Morning", "Afternoon", "Night"], width=18, 
                      state="readonly", font=LABEL_FONT, style='Custom.TCombobox')
combo4.set("Night")
combo4.pack(anchor="w", pady=(2, 0))

# Row 2: Q5 | Q6
q5_frame = add_compact_question(q_container, 2, 0, 5, "How long can you focus without losing concentration?")
combo5 = ttk.Combobox(q5_frame, values=["<30 min", "30–60 min", ">60 min"], width=18, 
                      state="readonly", font=LABEL_FONT, style='Custom.TCombobox')
combo5.set("<30 min")
combo5.pack(anchor="w", pady=(2, 0))

q6_frame = add_compact_question(q_container, 2, 1, 6, "What kind of background sound helps you study best?")
combo6 = ttk.Combobox(q6_frame, values=["Complete silence", "Minimal sound", "Instrumental", 
                      "Songs with lyrics", "White noise"], width=18, state="readonly", 
                      font=LABEL_FONT, style='Custom.TCombobox')
combo6.set("Instrumental")
combo6.pack(anchor="w", pady=(2, 0))

# Row 3: Q7 | Q8
q7_frame = add_compact_question(q_container, 3, 0, 7, "Do you prefer studying alone or with others?")
combo7 = ttk.Combobox(q7_frame, values=["Alone", "1 friend", "2–3 friends"], width=18, 
                      state="readonly", font=LABEL_FONT, style='Custom.TCombobox')
combo7.set("Alone")
combo7.pack(anchor="w", pady=(2, 0))

q8_frame = add_compact_question(q_container, 3, 1, 8, "Do you prefer staying at a desk or moving around while studying?")
combo8 = ttk.Combobox(q8_frame, values=["Fixed desk", "Move around"], width=18, 
                      state="readonly", font=LABEL_FONT, style='Custom.TCombobox')
combo8.set("Fixed desk")
combo8.pack(anchor="w", pady=(2, 0))

# Row 4: Q9 | Q10
q9_frame = add_compact_question(q_container, 4, 0, 9, "Which type of exam are you currently preparing for?")
combo9 = ttk.Combobox(q9_frame, values=["MCQ", "Essay", "Practical", "Viva"], width=18, 
                      state="readonly", font=LABEL_FONT, style='Custom.TCombobox')
combo9.set("MCQ")
combo9.pack(anchor="w", pady=(2, 0))

q10_frame = add_compact_question(q_container, 4, 1, 10, "Do you often forget answers or feel blank when the exam timer is running?")
var10 = tk.BooleanVar()
btn_frame10 = tk.Frame(q10_frame, bg=CARD_BG)
btn_frame10.pack(anchor="w", pady=(2, 0))
tk.Radiobutton(btn_frame10, text="Yes", variable=var10, value=True, bg=CARD_BG,
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left", padx=(0, 10))
tk.Radiobutton(btn_frame10, text="No", variable=var10, value=False, bg=CARD_BG,
               fg=TEXT_PRIMARY, selectcolor=CARD_BG, font=LABEL_FONT).pack(side="left")

# Button at bottom spanning both columns
def on_enter(e):
    btn_generate.config(bg=ACCENT_HOVER)

def on_leave(e):
    if btn_generate['state'] != 'disabled':
        btn_generate.config(bg=ACCENT)

btn_frame = tk.Frame(q_container, bg=CARD_BG)
btn_frame.grid(row=5, column=0, columnspan=2, pady=(15, 5))

btn_generate = tk.Button(btn_frame, text="Generate Study Plan", font=BUTTON_FONT,
                         bg=ACCENT, fg=TEXT_PRIMARY, activebackground=ACCENT_HOVER, 
                         activeforeground=TEXT_PRIMARY, relief="flat", padx=40, pady=10, 
                         command=run_prolog, cursor="hand2", bd=0)
btn_generate.pack()
btn_generate.bind("<Enter>", on_enter)
btn_generate.bind("<Leave>", on_leave)

# RIGHT: Results panel
right = tk.Frame(content, bg=CARD_BG, highlightbackground=BORDER, highlightthickness=1)
right.pack(side="right", fill="both", expand=True)

result_header = tk.Frame(right, bg=CARD_BG)
result_header.pack(fill="x", padx=15, pady=(12, 8))
tk.Label(result_header, text="YOUR PERSONALIZED STUDY PLAN", font=SECTION_FONT, 
         bg=CARD_BG, fg=TEXT_PRIMARY).pack(anchor="w")

text_result = scrolledtext.ScrolledText(right, font=RESULT_FONT, bg=RESULT_BG, fg=TEXT_PRIMARY,
                                        relief="flat", bd=0, padx=15, pady=12, wrap="word",
                                        highlightthickness=0, spacing1=2, spacing3=1)
text_result.pack(fill="both", expand=True, padx=12, pady=(0, 12))

# Configure text tags for professional styling
text_result.tag_configure("section_header", font=SECTION_FONT, foreground=TEXT_PRIMARY, 
                         spacing1=10, spacing3=6, underline=False)
text_result.tag_configure("bullet", foreground=TEXT_PRIMARY, font=RESULT_FONT, 
                         lmargin1=10, lmargin2=10)
text_result.tag_configure("label", foreground=TEXT_SECONDARY, font=RESULT_FONT)
text_result.tag_configure("value", foreground=TEXT_PRIMARY, font=VALUE_FONT)
text_result.tag_configure("loading", foreground=TEXT_PRIMARY, font=(RESULT_FONT[0], 10), 
                         justify="center")
text_result.tag_configure("error", foreground="#cc0000", font=RESULT_FONT)

text_result.insert('1.0', "Your personalized study plan will appear here.\n\n"
                   "Complete all questions and click 'Generate Study Plan' to begin.", 'loading')
text_result.config(state='disabled')

print("✓ Optimized Full-Screen UI initialized")
root.mainloop()