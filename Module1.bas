Attribute VB_Name = "modStuff"
Private Declare Function SystemParametersInfo Lib "user32" _
Alias "SystemParametersInfoA" (ByVal uAction As Long, ByVal _
uParam As Long, ByVal lpvParam As Long, ByVal fuWinIni As _
Long) As Long

Private Declare Function ExitWindowsEx Lib "user32" (ByVal dwOptions As Long, ByVal dwReserved As Long) As Long
Private Const EWX_REBOOT As Long = 2

Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long

Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cX As Long, ByVal cY As Long, ByVal wFlags As Long) As Long
Const SWP_HIDEWINDOW = &H80
Const SWP_SHOWWINDOW = &H40

Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Const KEYEVENTF_KEYUP = &H2
Const VK_LWIN = &H5B

Private Const MF_BYPOSITION = &H400&
Private Const MF_REMOVE = &H1000&


Private Declare Function GetSystemMenu Lib "user32" _
        (ByVal hWnd As Long, ByVal bRevert As Long) As Long


Private Declare Function GetMenuItemCount Lib "user32" _
        (ByVal hMenu As Long) As Long


Private Declare Function DrawMenuBar Lib "user32" _
        (ByVal hWnd As Long) As Long


Private Declare Function RemoveMenu Lib "user32" _
        (ByVal hMenu As Long, ByVal nPosition As Long, _
        ByVal wFlags As Long) As Long

Function CTRL_ALT_DEL_Enabled()
callme (False)
End Function
Function CTRL_ALT_DEL_Disabled()
callme (True)
End Function
Private Sub callme(huh As Boolean)
Dim gd
gd = SystemParametersInfo(97, huh, CStr(1), 0)
End Sub
Function TaskBarHide()
Dim rtn
rtn = FindWindow("Shell_traywnd", "")
Call SetWindowPos(rtn, 0, 0, 0, 0, 0, SWP_HIDEWINDOW)
End Function
Function TaskBarShow()
Dim rtn As Long
rtn = FindWindow("Shell_traywnd", "")
Call SetWindowPos(rtn, 0, 0, 0, 0, 0, SWP_SHOWWINDOW)
End Function
Function DesktopIconsShow()
Dim hWnd As Long
hWnd = FindWindowEx(0&, 0&, "Progman", vbNullString)
ShowWindow hWnd, 5
End Function
Function DesktopIconsHide()
Dim hWnd As Long
hWnd = FindWindowEx(0&, 0&, "Progman", vbNullString)
ShowWindow hWnd, 0
End Function
Function MinimizeAll()
Call keybd_event(VK_LWIN, 0, 0, 0)
Call keybd_event(77, 0, 0, 0)
Call keybd_event(VK_LWIN, 0, KEYEVENTF_KEYUP, 0)
End Function
Function DisableX()
Dim hSysMenu As Long
        Dim nCnt As Long
        frmMain.Show
        hSysMenu = GetSystemMenu(frmMain.hWnd, False)
        If hSysMenu Then
            nCnt = GetMenuItemCount(hSysMenu)
            If nCnt Then
                RemoveMenu hSysMenu, nCnt - 1, _
                    MF_BYPOSITION Or MF_REMOVE
                RemoveMenu hSysMenu, nCnt - 2, _
                    MF_BYPOSITION Or MF_REMOVE
                DrawMenuBar frmMain.hWnd
            End If
        End If
End Function
Function FilesSearch(DrivePath As String, Ext As String)
    Dim XDir() As String
    Dim TmpDir As String
    Dim FFound As String
    Dim DirCount As Integer
    Dim X As Integer
    'Initialises Variables
    DirCount = 0
    ReDim XDir(0) As String
    XDir(DirCount) = ""


    If Right(DrivePath, 1) <> "\" Then
        DrivePath = DrivePath & "\"
    End If
    'Enter here the code for showing the pat
    '     h being
    'search. Example: Form1.label2 = DrivePa
    '     th
    'Search for all directories and store in
    '     the
    'XDir() variable


    DoEvents
        TmpDir = Dir(DrivePath, vbDirectory)


        Do While TmpDir <> ""


            If TmpDir <> "." And TmpDir <> ".." Then


                If (GetAttr(DrivePath & TmpDir) And vbDirectory) = vbDirectory Then
                    XDir(DirCount) = DrivePath & TmpDir & "\"
                    DirCount = DirCount + 1
                    ReDim Preserve XDir(DirCount) As String
                End If
            End If
            TmpDir = Dir
        Loop
        'Searches for the files given by extensi
        '     on Ext
        FFound = Dir(DrivePath & Ext)


        Do Until FFound = ""
            'Code in here for the actions of the fil
            '     es found.
            'Files found stored in the variable FFou
            '     nd.
            'Example: Form1.list1.AddItem DrivePath
            '     & FFound
            FFound = Dir
        Loop
        'Recursive searches through all sub dire
        '     ctories


        For X = 0 To (UBound(XDir) - 1)
            FilesSearch XDir(X), Ext
        Next X
    End Function


Function Restart()
Dim lngresult
lngresult = ExitWindowsEx(EWX_REBOOT, 0&)
End Function
