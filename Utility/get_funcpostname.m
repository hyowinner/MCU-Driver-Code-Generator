function postname = get_funcpostname(pvstr)
% This funciton get function post name from g_pv string
res = regexp(pvstr, '[,;]', 'split');
postname = res{3};
end