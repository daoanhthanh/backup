; xem thêm ở đây: https://www.autohotkey.com/docs/v1/Hotkeys.htm


+space::
{
    WinSetAlwaysOnTop -1, "A"
}

^!T::
{
  ; Đường dẫn tương đối cho mỗi máy "%LocalAppData%\Microsoft\WindowsApps\wt.exe"
  Run "C:\Users\thanh_da\AppData\Local\Microsoft\WindowsApps\wt.exe"
}
