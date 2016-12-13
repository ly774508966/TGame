local ss = {};

ss["aa"] = "1";
ss["aa"] = "2";
ss["aa"] = "3";
ss[1] = "aa";
ss[2] = "bb";
function removeTableName(tab,name)
	table.remove(tab,name);
end


print(#ss);
print(ss[1]);
table.remove(ss,1);
print(#ss);
print(ss[1]);

