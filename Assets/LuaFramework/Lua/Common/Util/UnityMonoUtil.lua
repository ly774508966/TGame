UnityMonoUtil = {}

function UnityMonoUtil:FindChild(go,url)
	return go.transform:FindChild(url).gameObject;
end

function UnityMonoUtil:AddOnClick(lb,go,func,...)
	lb:AddClickArgs(go,func,{...});
end


