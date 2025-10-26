# % prolog_kb.pl - UTF-8 SAFE (FIXED - More Robust)
# :- set_prolog_flag(encoding, utf8).
# :- dynamic draws_diagrams/1, explains_aloud/1, needs_practice/1.
# :- dynamic energy_peak/1, focus_span/1, sound_preference/1.
# :- dynamic group_size/1, study_location/1, exam_priority/1, time_pressure_panic/1.

# generate_plan :-
#     format('~n========================================~n', []),
#     format('YOUR SMART STUDY FIT~n', []),
#     format('========================================~n~n', []),

#     % Learning Style
#     (learning_style(LS) -> 
#         format('📚 LEARNING STYLE: ~w~n~n', [LS])
#     ; 
#         format('📚 LEARNING STYLE: Unable to determine~n~n', [])
#     ),

#     % Best Time
#     (best_time(T) -> 
#         format('⏰ BEST TIME: ~w~n~n', [T])
#     ; 
#         format('⏰ BEST TIME: Flexible~n~n', [])
#     ),

#     % Environment
#     format('🌍 ENVIRONMENT:~n', []),
#     print_environment,
#     nl,

#     % Session Plan
#     format('📋 SESSION PLAN:~n', []),
#     (session_plan(SP) -> 
#         format('   ✓ ~w~n', [SP])
#     ; 
#         format('   ✓ Custom plan based on your preferences~n', [])
#     ),
#     nl,

#     % Techniques
#     format('🎯 TECHNIQUES:~n', []),
#     print_techniques,
#     nl,

#     % Tools
#     format('🛠️  TOOLS:~n', []),
#     print_tools,
#     nl,

#     % Tips
#     format('💡 TIPS:~n', []),
#     print_tips,
#     nl,
#     format('========================================~n', []).

# % Print environment details
# print_environment :-
#     (group_size(small_group), study_location(fixed) -> 
#         format('   ✓ Study in room with 2-3 friends~n', []) 
#     ; true),
#     (group_size(one_friend) -> 
#         format('   ✓ Study with 1 friend~n', []) 
#     ; true),
#     (group_size(alone) -> 
#         format('   ✓ Study alone in quiet space~n', []) 
#     ; true),
#     (sound_preference(instrumental) -> 
#         format('   ✓ Play instrumental lo-fi music~n', []) 
#     ; true),
#     (sound_preference(complete_silence) -> 
#         format('   ✓ Complete silence (use earplugs if needed)~n', []) 
#     ; true),
#     (sound_preference(white_noise) -> 
#         format('   ✓ Use white noise or nature sounds~n', []) 
#     ; true),
#     (sound_preference(lyrics) -> 
#         format('   ✓ Can study with songs (keep volume low)~n', []) 
#     ; true),
#     (study_location(fixed), draws_diagrams(yes) -> 
#         format('   ✓ Fixed desk with whiteboard/paper~n', []) 
#     ; true),
#     (study_location(move_around) -> 
#         format('   ✓ Walk around while studying~n', []) 
#     ; true),
#     (group_size(small_group) -> 
#         format('   ✓ No talking during focus blocks~n', []) 
#     ; true).

# % Print techniques
# print_techniques :-
#     (draws_diagrams(yes) -> 
#         format('   ✓ Draw mind maps and diagrams~n', []) 
#     ; true),
#     (explains_aloud(yes), group_size(small_group) -> 
#         format('   ✓ Teach concepts to your group~n', []) 
#     ; true),
#     (explains_aloud(yes), group_size(alone) -> 
#         format('   ✓ Explain concepts aloud to yourself~n', []) 
#     ; true),
#     (needs_practice(yes), exam_priority(mcq) -> 
#         format('   ✓ Solve 5-10 practice MCQs per session~n', []) 
#     ; true),
#     (needs_practice(yes), exam_priority(essay) -> 
#         format('   ✓ Practice writing essay outlines~n', []) 
#     ; true),
#     (needs_practice(yes), exam_priority(practical) -> 
#         format('   ✓ Do hands-on practical exercises~n', []) 
#     ; true),
#     (exam_priority(essay) -> 
#         format('   ✓ Write 1 paragraph summary per topic~n', []) 
#     ; true),
#     (exam_priority(viva) -> 
#         format('   ✓ Practice explaining orally~n', []) 
#     ; true),
#     % Ensure at least one technique is shown
#     (\+ draws_diagrams(yes), \+ explains_aloud(yes), \+ needs_practice(yes) -> 
#         format('   ✓ Read and summarize key points~n', []) 
#     ; true).

# % Print tools
# print_tools :-
#     (draws_diagrams(yes) -> 
#         format('   ✓ Whiteboard, markers, notebook~n', []) 
#     ; true),
#     (sound_preference(instrumental) -> 
#         format('   ✓ Lo-fi playlist (YouTube/Spotify)~n', []) 
#     ; true),
#     (focus_span('<30_min') -> 
#         format('   ✓ Pomodoro timer app~n', []) 
#     ; true),
#     (exam_priority(mcq) -> 
#         format('   ✓ Anki or Quizlet for flashcards~n', []) 
#     ; true),
#     (exam_priority(essay) -> 
#         format('   ✓ Outline templates~n', []) 
#     ; true),
#     % Always suggest at least basic tools
#     format('   ✓ Notebook and pen~n', []).

# % Print tips
# print_tips :-
#     (time_pressure_panic(yes) -> 
#         format('   ✓ Take 3 deep breaths if you blank out~n', []) 
#     ; true),
#     (time_pressure_panic(yes) -> 
#         format('   ✓ Practice timed mock tests~n', []) 
#     ; true),
#     (group_size(small_group) -> 
#         format('   ✓ Quiz each other: "Why this answer?"~n', []) 
#     ; true),
#     (needs_practice(yes), exam_priority(mcq) -> 
#         format('   ✓ Review wrong answers - draw/explain them~n', []) 
#     ; true),
#     (focus_span('<30_min') -> 
#         format('   ✓ Take 5-min breaks to stay fresh~n', []) 
#     ; true),
#     (energy_peak(night) -> 
#         format('   ✓ Keep snacks and water nearby~n', []) 
#     ; true),
#     % Always give general tip
#     format('   ✓ Stay consistent with your schedule~n', []).

# % RULES - Learning Style
# learning_style('Hybrid (Visual + Auditory + Kinesthetic)') :- 
#     draws_diagrams(yes), explains_aloud(yes), needs_practice(yes), !.
# learning_style('Hybrid (Visual + Auditory)') :- 
#     draws_diagrams(yes), explains_aloud(yes), !.
# learning_style('Hybrid (Visual + Kinesthetic)') :- 
#     draws_diagrams(yes), needs_practice(yes), !.
# learning_style('Hybrid (Auditory + Kinesthetic)') :- 
#     explains_aloud(yes), needs_practice(yes), !.
# learning_style('Visual Learner') :- 
#     draws_diagrams(yes), !.
# learning_style('Auditory Learner') :- 
#     explains_aloud(yes), !.
# learning_style('Kinesthetic Learner') :- 
#     needs_practice(yes), !.
# learning_style('Balanced Multi-Modal').

# % RULES - Best Time
# best_time('Night (10 PM - 1 AM)') :- energy_peak(night), !.
# best_time('Morning (6-9 AM)') :- energy_peak(morning), !.
# best_time('Afternoon (2-5 PM)') :- energy_peak(afternoon), !.
# best_time('Flexible - any time works').

# % RULES - Session Plan (more specific to general)
# session_plan('Pomodoro: 25 min study + 5 min break → Do 10 MCQs → Explain 1 to group → Draw 1 diagram') :-
#     focus_span('<30_min'), exam_priority(mcq), group_size(small_group), draws_diagrams(yes), !.

# session_plan('Pomodoro: 25 min study + 5 min break → Solve 10 MCQs → Draw wrong answers') :-
#     focus_span('<30_min'), exam_priority(mcq), draws_diagrams(yes), !.

# session_plan('Pomodoro: 25 min study + 5 min break → Teach 1 concept to group') :-
#     focus_span('<30_min'), group_size(small_group), explains_aloud(yes), !.

# session_plan('50 min study + 10 min break → Solve 5 MCQs → Teach 1 concept') :-
#     focus_span('30-60_min'), exam_priority(mcq), explains_aloud(yes), !.

# session_plan('50 min study + 10 min break → Read → Practice → Review') :-
#     focus_span('30-60_min'), !.

# session_plan('Pomodoro: 25 min study + 5 min break (4 cycles)') :-
#     focus_span('<30_min'), !.

# session_plan('90 min deep work with short breaks') :-
#     focus_span('>60_min'), !.

# session_plan('Flexible sessions based on your energy level').



% prolog_kb.pl - Enhanced Knowledge Base for Assignment
% Smart Study Fit Advisor - Expert System
% This KB contains 25+ rules and provides personalized study recommendations

:- set_prolog_flag(encoding, utf8).

% Dynamic facts - will be loaded from user input
:- dynamic draws_diagrams/1, explains_aloud/1, needs_practice/1.
:- dynamic energy_peak/1, focus_span/1, sound_preference/1.
:- dynamic group_size/1, study_location/1, exam_priority/1, time_pressure_panic/1.

%==============================================================================
% MAIN EXPERT SYSTEM ENTRY POINT
%==============================================================================
generate_plan :-
    format('~n╔════════════════════════════════════════════════════════════╗~n', []),
    format('║           SMART STUDY FIT - EXPERT SYSTEM                  ║~n', []),
    format('║        Your Personalized Study Recommendation              ║~n', []),
    format('╚════════════════════════════════════════════════════════════╝~n~n', []),
    
    % Core analysis
    analyze_learning_profile,
    nl,
    
    % Recommendations
    recommend_study_environment,
    nl,
    recommend_session_structure,
    nl,
    recommend_techniques,
    nl,
    recommend_tools,
    nl,
    recommend_exam_strategy,
    nl,
    provide_motivation_tips,
    nl,
    
    format('╚════════════════════════════════════════════════════════════╝~n', []).

%==============================================================================
% RULE 1-5: LEARNING STYLE CLASSIFICATION (Multiple Rules)
%==============================================================================
analyze_learning_profile :-
    format('📚 LEARNING PROFILE ANALYSIS~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    % Determine learning style
    learning_style(LS),
    format('   Learning Style: ~w~n', [LS]),
    
    % Determine cognitive strength
    cognitive_strength(CS),
    format('   Cognitive Strength: ~w~n', [CS]),
    
    % Best study time
    best_time(T),
    format('   Optimal Time: ~w~n', [T]),
    
    % Focus capacity
    focus_capacity(FC),
    format('   Focus Capacity: ~w~n', [FC]),
    
    % Stress response
    stress_profile(SP),
    format('   Stress Profile: ~w~n', [SP]).

% Learning style rules (5 rules)
learning_style('Multi-Modal Learner (Visual + Auditory + Kinesthetic)') :- 
    draws_diagrams(yes), explains_aloud(yes), needs_practice(yes), !.
learning_style('Dual-Modal: Visual-Auditory') :- 
    draws_diagrams(yes), explains_aloud(yes), !.
learning_style('Dual-Modal: Visual-Kinesthetic') :- 
    draws_diagrams(yes), needs_practice(yes), !.
learning_style('Dual-Modal: Auditory-Kinesthetic') :- 
    explains_aloud(yes), needs_practice(yes), !.
learning_style('Visual Learner') :- draws_diagrams(yes), !.
learning_style('Auditory Learner') :- explains_aloud(yes), !.
learning_style('Kinesthetic Learner') :- needs_practice(yes), !.
learning_style('Balanced/Read-Write Learner').

% Cognitive strength rules (3 rules)
cognitive_strength('Abstract Reasoning') :- 
    draws_diagrams(yes), \+ needs_practice(yes), !.
cognitive_strength('Verbal Processing') :- 
    explains_aloud(yes), \+ draws_diagrams(yes), !.
cognitive_strength('Applied Learning') :- 
    needs_practice(yes), !.
cognitive_strength('Conceptual Understanding').

% Time preference rules (4 rules)
best_time('Night Owl (10 PM - 1 AM) - Peak creativity hours') :- 
    energy_peak(night), !.
best_time('Morning Lark (6-9 AM) - Peak alertness hours') :- 
    energy_peak(morning), !.
best_time('Afternoon Worker (2-5 PM) - Peak productivity hours') :- 
    energy_peak(afternoon), !.
best_time('Flexible schedule - No strong preference').

% Focus capacity rules (3 rules)
focus_capacity('Sprint Learner (<30 min focus blocks)') :- 
    focus_span('<30_min'), !.
focus_capacity('Standard Focus (30-60 min blocks)') :- 
    focus_span('30-60_min'), !.
focus_capacity('Deep Work Capable (60+ min blocks)') :- 
    focus_span('>60_min'), !.
focus_capacity('Variable focus duration').

% Stress response rules (2 rules)
stress_profile('High Test Anxiety - Needs stress management') :- 
    time_pressure_panic(yes), !.
stress_profile('Calm Under Pressure').

%==============================================================================
% RULE 6-10: ENVIRONMENT RECOMMENDATION
%==============================================================================
recommend_study_environment :-
    format('🌍 RECOMMENDED STUDY ENVIRONMENT~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    % Location setup
    location_setup(Loc),
    format('   Location Setup: ~w~n', [Loc]),
    
    % Sound environment
    sound_setup(Sound),
    format('   Sound Environment: ~w~n', [Sound]),
    
    % Social setup
    social_setup(Social),
    format('   Social Setting: ~w~n', [Social]),
    
    % Additional environment factors
    recommend_lighting,
    recommend_materials.

% Location setup rules (2 rules)
location_setup('Fixed desk with organized materials') :- 
    study_location(fixed), !.
location_setup('Mobile setup - walk while studying').

% Sound environment rules (5 rules)
sound_setup('Complete silence with noise-cancelling') :- 
    sound_preference(complete_silence), !.
sound_setup('Quiet environment, minimal background noise') :- 
    sound_preference(minimal_sound), !.
sound_setup('Instrumental music (lo-fi, classical, ambient)') :- 
    sound_preference(instrumental), !.
sound_setup('Music with lyrics (keep volume moderate)') :- 
    sound_preference(lyrics), !.
sound_setup('White noise or nature sounds') :- 
    sound_preference(white_noise), !.
sound_setup('Quiet environment recommended').

% Social setup rules (3 rules)
social_setup('Solo study - minimize distractions') :- 
    group_size(alone), !.
social_setup('Study partner (1 friend) for accountability') :- 
    group_size(one_friend), !.
social_setup('Small study group (2-3 people) for discussion').

% Additional environment recommendations
recommend_lighting :-
    energy_peak(night),
    format('   Lighting: Use warm lighting to reduce eye strain~n', []), !.
recommend_lighting :-
    format('   Lighting: Natural daylight preferred~n', []).

recommend_materials :-
    draws_diagrams(yes),
    format('   Materials: Whiteboard, colored markers, large paper~n', []), !.
recommend_materials :-
    format('   Materials: Notebook, highlighters, sticky notes~n', []).

%==============================================================================
% RULE 11-15: SESSION STRUCTURE (Complex conditional rules)
%==============================================================================
recommend_session_structure :-
    format('📋 RECOMMENDED SESSION STRUCTURE~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    session_plan(Plan),
    format('   ~w~n', [Plan]),
    
    break_strategy(Break),
    format('   Break Strategy: ~w~n', [Break]),
    
    daily_schedule(Schedule),
    format('   Daily Schedule: ~w~n', [Schedule]).

% Session plan rules (6 complex rules)
session_plan('POMODORO: 25 min study → 5 min break (4 cycles) → 15 min long break') :-
    focus_span('<30_min'), !.

session_plan('STANDARD: 50 min study → 10 min break (3 cycles) → 20 min long break') :-
    focus_span('30-60_min'), !.

session_plan('DEEP WORK: 90 min intensive study → 20 min break (2 cycles)') :-
    focus_span('>60_min'), !.

session_plan('FLEXIBLE: Adjust based on energy levels').

% Break strategy rules (3 rules)
break_strategy('Active breaks - walk, stretch, snack') :- 
    study_location(move_around), !.
break_strategy('Mindful breaks - meditation, deep breathing') :- 
    time_pressure_panic(yes), !.
break_strategy('Short breaks - step away from desk').

% Daily schedule rules (3 rules)
daily_schedule('Study during night hours (10 PM - 1 AM)') :- 
    energy_peak(night), !.
daily_schedule('Study in early morning (6-9 AM)') :- 
    energy_peak(morning), !.
daily_schedule('Study in afternoon (2-5 PM)') :- 
    energy_peak(afternoon), !.
daily_schedule('Flexible daily schedule').

%==============================================================================
% RULE 16-20: TECHNIQUE RECOMMENDATIONS
%==============================================================================
recommend_techniques :-
    format('🎯 RECOMMENDED STUDY TECHNIQUES~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    primary_technique(PT),
    format('   Primary: ~w~n', [PT]),
    
    secondary_technique(ST),
    format('   Secondary: ~w~n', [ST]),
    
    review_technique(RT),
    format('   Review: ~w~n', [RT]).

% Primary technique rules (7 rules - exam specific)
primary_technique('Mind mapping and visual diagrams') :- 
    draws_diagrams(yes), exam_priority(essay), !.
primary_technique('Concept explanation and teaching method') :- 
    explains_aloud(yes), exam_priority(viva), !.
primary_technique('Practice problems and mock tests') :- 
    needs_practice(yes), exam_priority(mcq), !.
primary_technique('Hands-on practical exercises') :- 
    needs_practice(yes), exam_priority(practical), !.
primary_technique('Visual note-taking with Cornell method') :- 
    draws_diagrams(yes), !.
primary_technique('Verbal rehearsal and self-explanation') :- 
    explains_aloud(yes), !.
primary_technique('Active recall and spaced repetition').

% Secondary technique rules (3 rules)
secondary_technique('Group discussion and peer teaching') :- 
    group_size(small_group), explains_aloud(yes), !.
secondary_technique('Flashcards and quick reviews') :- 
    focus_span('<30_min'), !.
secondary_technique('Summary writing and note consolidation').

% Review technique rules (2 rules)
review_technique('Daily review + Weekly comprehensive review') :- 
    time_pressure_panic(yes), !.
review_technique('Review after each major topic').

%==============================================================================
% RULE 21-23: TOOL RECOMMENDATIONS
%==============================================================================
recommend_tools :-
    format('🛠️  RECOMMENDED TOOLS & RESOURCES~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    digital_tools(DT),
    format('   Digital: ~w~n', [DT]),
    
    physical_tools(PT),
    format('   Physical: ~w~n', [PT]),
    
    online_resources(OR),
    format('   Online: ~w~n', [OR]).

% Digital tools (exam-specific, 4 rules)
digital_tools('Anki (flashcards), Quizlet, Forest (focus timer)') :- 
    exam_priority(mcq), !.
digital_tools('Notion, Obsidian, MindMeister (mind maps)') :- 
    exam_priority(essay), draws_diagrams(yes), !.
digital_tools('Practice platforms, coding environments') :- 
    exam_priority(practical), !.
digital_tools('Pomodoro timer apps, note-taking apps').

% Physical tools (2 rules)
physical_tools('Whiteboard, colored markers, chart paper') :- 
    draws_diagrams(yes), !.
physical_tools('Quality notebooks, highlighters, sticky notes').

% Online resources (1 rule)
online_resources('YouTube tutorials, Khan Academy, course forums').

%==============================================================================
% RULE 24-25: EXAM-SPECIFIC STRATEGY
%==============================================================================
recommend_exam_strategy :-
    format('🎓 EXAM-SPECIFIC STRATEGY~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    exam_strategy(Strategy),
    format('   ~w~n', [Strategy]),
    
    time_management_tip(Tip),
    format('   Time Management: ~w~n', [Tip]).

% Exam strategy (4 rules based on priority)
exam_strategy('MCQ STRATEGY: Practice 50+ questions, analyze wrong answers, learn elimination techniques') :- 
    exam_priority(mcq), !.
exam_strategy('ESSAY STRATEGY: Create outlines, practice timed writing, learn transition phrases') :- 
    exam_priority(essay), !.
exam_strategy('PRACTICAL STRATEGY: Hands-on practice daily, understand concepts not just steps') :- 
    exam_priority(practical), !.
exam_strategy('VIVA STRATEGY: Practice explaining concepts aloud, prepare for follow-up questions') :- 
    exam_priority(viva), !.
exam_strategy('GENERAL: Balance all exam components').

% Time management (2 rules)
time_management_tip('Practice with timer, simulate exam conditions weekly') :- 
    time_pressure_panic(yes), !.
time_management_tip('Allocate time per question/section, leave buffer for review').

%==============================================================================
% MOTIVATION & WELLNESS TIPS
%==============================================================================
provide_motivation_tips :-
    format('💡 MOTIVATION & WELLNESS TIPS~n', []),
    format('─────────────────────────────────────────────────────────────~n', []),
    
    % Stress management
    (time_pressure_panic(yes) -> 
        format('   ✓ Practice 4-7-8 breathing before exams~n', []),
        format('   ✓ Use progressive muscle relaxation~n', [])
    ; true),
    
    % Energy management
    (energy_peak(night) -> 
        format('   ✓ Keep healthy snacks nearby~n', []),
        format('   ✓ Stay hydrated, avoid excessive caffeine~n', [])
    ; true),
    
    % Group dynamics
    (group_size(small_group) -> 
        format('   ✓ Set ground rules for group study~n', []),
        format('   ✓ Assign roles and rotate teaching~n', [])
    ; true),
    
    % Universal tips
    format('   ✓ Reward yourself after completing goals~n', []),
    format('   ✓ Track progress weekly~n', []),
    format('   ✓ Maintain consistent sleep schedule~n', []),
    format('   ✓ Exercise 20-30 minutes daily~n', []).

%==============================================================================
% END OF KNOWLEDGE BASE
% Total Rules: 25+ conditional rules with multiple inference paths
%==============================================================================