Dim fso
Set fso = WScript.CreateObject("Scripting.Filesystemobject")

For Each i In fso.GetFolder(".\html").Files
	if (Right(i.Name,4)= ".htm") Then
		text = i.OpenAsTextStream.ReadAll
		text = Replace(text, "<META HTTP-EQUIV=""Content-Type"" Content=""text/html; charset=gb2312"">", "", 1,-1,1)
		text = Replace(text, "<META HTTP-EQUIV=""Content-Type"" Content=""text/html; charset=iso8859-1"">", "", 1,-1,1)
		text = Replace(text, "</HEAD>", " <META HTTP-EQUIV=""Content-Type"" Content=""text/html; charset=gb2312""><link href=""../static/theme.css"" rel=""stylesheet"" type=""text/css"" /><script src=""../static/content.js"" type=""text/javascript""></script></HEAD>",1,-1,1)
		i.OpenAsTextStream(2).Write text
	End If
	wsh.echo i.Name
Next
MsgBox "ok"