# Custom Malware Detector (BAT Script)

## 📌 About
This is a **custom malware and spyware detector** written in a simple **Batch (.BAT) script**. It scans your files and system for suspicious activity, such as:
- Hidden or system files (common in malware behavior)
- Suspicious file types (`.exe`, `.bat`, `.vbs`, `.cmd`, etc.)
- Known malicious strings inside scripts
- Potentially dangerous running processes
- Logs all results to a text file for review

## ⚠️ Important Notes
- This **does not remove** malware; it only detects suspicious activity.
- You must **run it as an Administrator** for full access.
- The scan log is saved to your **Desktop (OneDrive/Desktop if applicable).**
- This is a **basic detection tool**, not a replacement for antivirus software.

## 🛠️ How to Use
1. **Download or copy the script**
2. **Save it as** `MalwareScanner.bat`
3. **Right-click the file → Run as Administrator**
4. **Wait for the scan to complete** (it includes 3-second delays for readability)
5. **Check the log file** at:
   ```
   C:\Users\YourUsername\OneDrive\Desktop\MalwareScanLog.txt
   ```
6. **Review the results** and manually inspect any suspicious files or processes

## 📝 What It Scans
✅ Suspicious file types (`.exe`, `.bat`, `.vbs`, `.cmd`, `.scr`, `.dll`, etc.)  
✅ Hidden/system files that may be malware  
✅ Known malware strings in scripts  
✅ Suspicious running processes (`powershell.exe`, `cmd.exe /c`, `wscript.exe`, etc.)  
✅ Logs everything in `MalwareScanLog.txt`  

## 🛑 Disclaimer
This tool is for **educational and informational purposes only**. It does not replace real-time antivirus software. Use it at your own risk.

## 🔧 Customization
- You can change the **scan directory** by modifying this line in the script:
  ```bat
  set SCAN_DIR=C:\Users\%USERNAME%\Documents
  ```
- You can add more **file types** to scan by modifying this part:
  ```bat
  for %%x in (exe bat vbs scr cmd js wsf lnk dll) do (...)
  ```

---
🚀 **Developed for Windows users who want a quick and simple way to check for malware-like activity.**

