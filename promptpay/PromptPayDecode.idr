module PromptPayDecode
-- Usage: ./promptpaydecode <promptpay-payload-string>

import System
import Data.List 


getTagId: String -> String
getTagId s = substr 0 2 s

getValueLength: String -> Nat
getValueLength s = cast(substr 2 2 s)

getValue: Nat -> String -> String
getValue l s = substr 4 l s


record TagInformation where
  constructor MkTagInformation
  tagId: String
  value: String

Show TagInformation where
  show r = r.tagId ++ " : " ++ r.value

tagIdToName: String -> String
tagIdToName "00" = "PAYLOAD_FORMAT_INDICATOR"
tagIdToName "01" = "POINT_OF_INITIATION_METHOD"
tagIdToName "29" = "PROMPTPAY_CREDIT_TRANSFER"
tagIdToName "30" = "PROMPTPAY_BILL_PAYMENT"
tagIdToName "52" = "MCC"
tagIdToName "53" = "CURRENCY_CODE"
tagIdToName "54" = "AMOUNT"
tagIdToName "55" = "TIP"
tagIdToName "58" = "COUNTRY_CODE"
tagIdToName "59" = "MERCHANT_NAME"
tagIdToName "60" = "MERCHANT_CITY"
tagIdToName "61" = "POSTAL_CODE"
tagIdToName "62" = "ADDITIONAL_DATA_FIELD"
tagIdToName "63" = "CRC"
tagIdToName "64" = "MERCHANT_INFORMATION"
tagIdToName "80" = "VAT_TQRC"
tagIdToName s    = s  -- unknown tag

export
decode: String -> List TagInformation
decode "" = []
decode s  = let l: Nat = getValueLength s in
                       let splitIndex: Nat = l + 4 in
                           MkTagInformation (tagIdToName (getTagId s)) (getValue l s) :: decode (substr splitIndex (minus (length s) splitIndex) s)


-- cli logic
processArgs: List String -> IO ()
processArgs [] = exitFailure
processArgs (args) = case (length args) of 
                          2 => case (last' args) of 
                                    Nothing => die "Cannot happen"
                                    Just x => putStrLn (show (decode x))
                          k => die "Only one CLI argument allowed"

main : IO ()
main = do
       args <- getArgs
       processArgs args
       exitSuccess
