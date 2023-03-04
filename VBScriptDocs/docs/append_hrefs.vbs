Dim fso
Set fso = WScript.CreateObject("Scripting.Filesystemobject")

For Each i In fso.GetFolder(".\html").Files
	if (Right(i.Name,4)= ".htm") Then
		text = i.OpenAsTextStream.ReadAll
		text = Replace(text, "<!--CSS_END-->", " <link href=""../static/theme.css"" rel=""stylesheet"" type=""text/css"" /><script src=""../static/content.js"" type=""text/javascript""></script><!--CSS_END-->")
		i.OpenAsTextStream(2).Write text
	End If
	wsh.echo i.Name
Next
MsgBox "ok"