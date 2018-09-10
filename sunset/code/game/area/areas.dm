/proc/area_contents(area/A)
	if(!istype(A))
		return null
	var/list/contents = list()
	for(var/area/LSA in A.related)
		contents += LSA.contents
	return contents