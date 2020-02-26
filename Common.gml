#define InitCommon()
	globalvar _old_maxSpd, _old_accel;
	
#define sTicks(seconds)
	return 60 * real(seconds);

#define mTicks(minutes)
	return 60 * 60 * real(minutes);

// Speed Helper Functions

#define GetSpeed()
	Trace("maxSpd: " + string(objPlayer.maxSpd));
	Trace("accel: " + string(objPlayer.accel));

#define ResetSpeedBuffs()
	if (flashPotionCountdown > 0
	|| potionOfSpeedCountdown > 0)
	{
		EndSpeedPotionBuff();
		EndFlashPotionBuff();
		RestoreSpeed();
	}
	
#define ResetSpeed()
	SetSpeedAccel(1,0.15);

#define CaptureSpeed()
	_old_maxSpd = objPlayer.maxSpd
	_old_accel = objPlayer.accel

#define RestoreSpeed()
	objPlayer.maxSpd = _old_maxSpd;
	objPlayer.accel = _old_accel;

#define SetSpeedAccel(maxSpd,accel)
	objPlayer.maxSpd = maxSpd;
	objPlayer.accel = accel;
	
#define NoScript
