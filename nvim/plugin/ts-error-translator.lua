local ok_ts_error_translator, ts_error_translator = pcall(require, 'ts-error-translator')

if not ok_ts_error_translator then return end

ts_error_translator.setup()
