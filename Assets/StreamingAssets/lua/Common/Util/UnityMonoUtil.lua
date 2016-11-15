UnityMonoUtil = {}

function UnityMonoUtil:FindChild(go,url)
	return go.transform:FindChild(url).gameObject;
end

function UnityMonoUtil:AddOnClick(lb,go,func)
	lb:AddClick(go,func);
end