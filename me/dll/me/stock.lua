--全局函数导入到模块中
local common			= require "me.common"
local dbg				= common.dbg

local EnvGetStkLabel	= EnvGetStkLabel
local EnvGetDataType	= EnvGetDataType
local EnvGetNumData		= EnvGetNumData
local EnvGetDataOpen	= EnvGetDataOpen
local EnvGetDataHigh	= EnvGetDataHigh
local EnvGetDataLow		= EnvGetDataLow
local EnvGetDataClose	= EnvGetDataClose
local EnvGetDataVolume	= EnvGetDataVolume

--模块定义
local base = _ENV
local _mode = {}
local _ENV = _mode


local	DT_TICK_DATA	= 2					--分笔
local	DT_MIN1_DATA	= 3					--1
local	DT_MIN5_DATA	= 4					--5					
local	DT_MIN15_DATA	= 5					--15
local	DT_MIN30_DATA	= 6					--30
local	DT_MIN60_DATA	= 7					--60
local	DT_DAY_DATA		= 8					--日
local	DT_WEEK_DATA	= 9					--周
local	DT_MONTH_DATA	= 10				--月
local	DT_MULTI_DATA	= 11				--多日

local	stkLabel		= ""
local	stkDataType		= 0
local	stkDatas		= {}
local	stkDataNum		= 0

function UpdateStk()
	local stk	= EnvGetStkLabel()
	local dt	= EnvGetDataType()
	local dn	= EnvGetNumData()
	if stk == stkLabel then
		if dt == stkDataType then
			if dn == stkDataNum then
				return
			end
		end
	end
	stkLabel = stk
	stkDataType = dt
	stkDataNum = dn
	dbg.message("UpdateStk(%s,%d,%d)\n", stkLabel, stkDataType, stkDataNum)
	
	for i=0,stkDataNum-1,1 do
		local data = {}
		data.open		= EnvGetDataOpen(i)
		data.high		= EnvGetDataHigh(i)
		data.low		= EnvGetDataLow(i)
		data.close		= EnvGetDataClose(i)
		data.volume		= EnvGetDataVolume(i)
		stkDatas[i]	= data
	end
	
end

--返回模块
return _mode