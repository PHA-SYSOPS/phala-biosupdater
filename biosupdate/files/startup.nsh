@echo off
mode 80 25
cls
;findimage section to locate correct drive

if exist fs0:\start-flash then
  fs0:
  echo Found BIOS update on fs0: drive
  goto FOUNDIMAGE
endif

if exist fs1:\start-flash then
  fs1:
  echo Found BIOS update on fs1: drive
  goto FOUNDIMAGE
endif

if exist fs2:\start-flash then
  fs2:
  echo Found BIOS update on fs2: drive
  goto FOUNDIMAGE
endif

if exist fs3:\start-flash then
  fs3:
  echo Found BIOS update on fs3: drive
  goto FOUNDIMAGE
endif

if exist fs4:\start-flash then
  fs4:
  echo Found BIOS update on fs4: drive
  goto FOUNDIMAGE
endif

echo "unable to find update permission, it does not exist or not located on fs0-fs4, skipping update"
echo ""
goto END

:FOUNDIMAGE
echo "*** WARNING WARNING WARNING WARNING WARNING ***"
echo "In the next step the BIOS update will be started."
echo "do NOT reboot, cancel or interupt this process!"
echo ""

echo "removing start-flash file, so next boot will be normal"
rm start-flash

echo "starting flashing with binary"
fpt64.efi -F GLKT3824V7.bin

echo "resetting system to apply BIOS"
reset

:END
echo "chainloading EFI SHIM for Ubuntu to start normal boot"
if exist fs0:\EFI\UBUNTU\SHIMX64.EFI then
  fs0:
endif
if exist fs1:\EFI\UBUNTU\SHIMX64.EFI then
  fs1:
endif
if exist fs2:\EFI\UBUNTU\SHIMX64.EFI then
  fs2:
endif
if exist fs3:\EFI\UBUNTU\SHIMX64.EFI then
  fs3:
endif
if exist fs4:\EFI\UBUNTU\SHIMX64.EFI then
  fs4:
endif

cd \EFI\UBUNTU
SHIMX64.EFI

