function navigate(mainDoc,navDoc)
{
	if(mainDoc!="")
	{
		top.frames.main.location = mainDoc;
	}
	if(navDoc!="")
	{
		top.frames.leftnav.location = navDoc;
	}
}