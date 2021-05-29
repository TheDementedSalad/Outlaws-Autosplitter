// Outlaws Autosplitter Version 2.0 22/10/2020
// Has splits for both Main Story and Marshall Training
// Supports real time
// Splits can be obtained from: 
// Partial script and corrections by Yoshii
// Splits/partial script by TheDementedSalad


// Special thanks to:
// Yoshi - helped explain A LOT of things regarding ASL code and how lists should look etc. and corrected/optimized how it looks.]
// TheDementedSalad - Found addresses for levels, menu and cutscenes for each split. Added and tested splits.
// Members of the ASL Discord - Helped point out easy mistakes and explained how to correctly split things.

state("olwin") {
	byte menu     : 0x1D4BC4;
	string8 level : 0x1D4BF0;
}

startup {
	vars.stopWatch = new Stopwatch();

	// Main Livesplit setttings
	settings.Add("AnyP", true, "Any%/Glitchless Splits");
		settings.Add("hideout", true, "Slim's Hideout", "AnyP");
		settings.Add("town", true, "Sanctuary", "AnyP");
		settings.Add("train", true, "Train", "AnyP");
		settings.Add("canyon", true, "River Basin", "AnyP");
		settings.Add("mill", true, "Sawmill", "AnyP");
		settings.Add("simms", true, "The Fort", "AnyP");
		settings.Add("miner", true, "The Iron Mine", "AnyP");
		settings.Add("cliff", true, "The Cliffs", "AnyP");
		settings.Add("ranch", true, "Bob Graham's Ranch", "AnyP");

	settings.Add("MarT", true, "Marshal Training/ Glitchless Splits");
		settings.Add("SHWILDNS", true, "Bloodeye Tim", "MarT");
		settings.Add("SHGULCH", true, "Dynamite Dick", "MarT");
		settings.Add("SHGRANRY", true, "Bloody Mary Nash", "MarT");
		settings.Add("SHSIMMS", true, "Buckshot Bill Morgan", "MarT");
		settings.Add("SHFORT", true, "Spittin' Sanchez", "MarT");
}

update {
	if (old.level != current.level) print(">>>>> level changed from " + old.level + " to " + current.level);
	if (old.menu != current.menu) print(">>>>> menu changed from " + old.menu + " to " + current.menu);
	if (timer.CurrentPhase == TimerPhase.NotRunning) vars.stopWatch.Reset();
}

exit {
	vars.stopWatch.Reset();
}

start {
	if (old.menu == 0 && current.menu == 3) {
		vars.stopWatch.Start();
		return true;
	}
}

split {
	return vars.stopWatch.ElapsedMilliseconds > 7000 && (
		current.level != old.level && settings[old.level] ||
		old.menu != current.menu && current.menu == 0 && current.level == "ranch");
}

reset {
	if (old.menu == 0 && current.menu == 3) {
		vars.stopWatch.Reset();
		return true;
	}
}