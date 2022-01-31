# the name of the drive to copy to
$drive_name = "RPI-RP2"
# the file name to copy to the drive
$file = "hid-servers-rp2040.uf2"

while (1) {
    
    # attempt to get usb drive matching given name
    $usb_drive = try { 
        $(Get-WmiObject Win32_LogicalDisk | Where-Object { $_.VolumeName -match $drive_name }).DeviceID.ToString() 
    } catch {
        "No disk found, waiting..."
        Start-Sleep -Milliseconds 500
        continue 
    }

    "COPY BEGIN"

    #mirror copy of files from "\\BACKUP_SERVER_IP\\d$\Backup" to "USB_DRIVE\VEEAM" folder
    robocopy .\ "$usb_drive" $file

    "DONE"
}

