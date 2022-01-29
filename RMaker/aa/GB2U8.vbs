' *==============================================================================*
' *  *
' * CodeChange.vbs     BY: yongfa365 http://www.yongfa365.com         2007-10-04 *
' * GB2U8.vbs          BY: fastslz   http://bbs.cn-dos.net            2007-12-03 *
' *==============================================================================*
aCode = "GB2312"
bCode = "UTF-8"
Show = "   "
Usage1 = ""
Usage2 = ""
Usage3 = "     "
Usage4 = "BY: fastslz"

Set objArgs=WScript.Arguments
Set fso=CreateObject("Scripting.FileSystemObject")
if objArgs.Count=0 Then
   MsgBox Show &vbCrLf&vbCrLf& Usage1 &vbCrLf& Usage2 &vbCrLf& Usage3, vbInformation, Usage4
   Wscript.Quit
end if
if not objArgs.Count < 3 Then
       Options="/y"
       ignoring = StrComp(objArgs(2), Options, vbTextCompare)
       if ignoring = 0 Then
          Sourcefile=objArgs(0)
          Getfile=objArgs(1)
          else
      MsgBox " ANSI2UTF8.vbs     ", vbInformation, "fsss"
          Wscript.Quit
       end if
       else
       if not objArgs.Count < 2 Then
          Sourcefile=objArgs(0)
          Getfile=objArgs(1)
          if fso.FileExists(objArgs(1)) then
             Choice = MsgBox ("a"+Sourcefile+" ==> b"+Getfile+"   "&vbCrLf&""+objArgs(1)+"   ",vbQuestion+vbYesNo,"")
             if Choice = vbYes Then
                Getfile=objArgs(1)
                else
                Wscript.Quit
             end if
          end if
          else
          Sourcefile=objArgs(0)
          Getfile=objArgs(0)
       end if
end if

Call CheckCode (Sourcefile)
Call WriteToFile(Getfile, ReadFile(Sourcefile, aCode), bCode)
Wscript.Quit

Function ReadFile (Sourcefile, CharSet)
    Dim Str
    Set stm = CreateObject("Adodb.Stream")
    stm.Type = 2
    stm.mode = 3
    stm.charset = CharSet
    stm.Open
    stm.loadfromfile Sourcefile
    Str = stm.readtext
    stm.Close
    Set stm = Nothing
    ReadFile = Str
End Function

Function WriteToFile (Getfile, Str, CharSet)
    Set stm = CreateObject("Adodb.Stream")
    stm.Type = 2
    stm.mode = 3
    stm.charset = CharSet
    stm.Open
    stm.WriteText Str
    stm.SaveToFile Getfile,2
    stm.flush
    stm.Close
    Set stm = Nothing
End Function

Function CheckCode (Sourcefile)
    Dim slz
    set slz = CreateObject("Adodb.Stream") 
    slz.Type = 1
    slz.Mode = 3
    slz.Open
    slz.Position = 0
    slz.Loadfromfile Sourcefile
    Bin=slz.read(2)
    if AscB(MidB(Bin,1,1))=&HEF and AscB(MidB(Bin,2,1))=&HBB Then
       Codes="UTF-8"
       elseif AscB(MidB(Bin,1,1))=&HFF and AscB(MidB(Bin,2,1))=&HFE Then
              Codes="Unicode"
              else
              Codes="GB2312"
    end if
    if not aCode = Codes Then
           
           WScript.Quit
    end if
    slz.Close
    set slz = Nothing
End Function
