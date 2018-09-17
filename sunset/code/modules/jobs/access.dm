/proc/get_sunset_accesses()
	return list(ACCESS_GENPOP_ENTER, ACCESS_GENPOP_EXIT)

/proc/get_sunset_desc(A)
	switch(A)
		if(ACCESS_GENPOP_ENTER)
			return "Genpop Enter"
		if(ACCESS_GENPOP_EXIT)
			return "Genpop Exit"