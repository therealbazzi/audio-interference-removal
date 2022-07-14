# audio-interference-removal

Just a small example on how one could remove interference from an audio baseband signal.

Here's some initializations to load the audio and listen to it 
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L4-L17

Then we plot the time domain signal as such
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L18-L34
<img width="659" alt="Screen Shot 2022-07-14 at 9 31 51 PM" src="https://user-images.githubusercontent.com/58386327/179046412-f7b49b68-c312-4a78-85e8-4e89e5b3f968.png">

Then observe in frequency domain the different interferers occuring causing this annoying bell sound in the background
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L36-L69
<img width="712" alt="Screen Shot 2022-07-14 at 9 33 06 PM" src="https://user-images.githubusercontent.com/58386327/179046589-ef181ff8-7f43-4bcf-ac6f-b59977424859.png">

Now, here's a very simple frequency-domain technique to seperate the bell from the original signal
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L71-L127
<img width="557" alt="Screen Shot 2022-07-14 at 9 35 50 PM" src="https://user-images.githubusercontent.com/58386327/179047038-c7713078-7146-4217-8102-8a46a171d8ff.png">

Then, we plot the corrected time domain signal
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L134-L146
<img width="675" alt="Screen Shot 2022-07-14 at 9 36 41 PM" src="https://user-images.githubusercontent.com/58386327/179047184-d1049e90-35ed-475c-ad66-78c75be33c16.png">

Then, we plot the corrected frequency domain signal
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L148-L161
<img width="546" alt="Screen Shot 2022-07-14 at 9 37 18 PM" src="https://user-images.githubusercontent.com/58386327/179047291-0c88921c-cf47-48e4-b6b1-596a262a65e0.png">

Then we save the corrected signal and listen to it
https://github.com/therealbazzi/audio-interference-removal/blob/461ad78a311b5c92255cd16f36ce8f223121ae84/main.m#L163-L180
