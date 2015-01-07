n=$GIT_AUTHOR_NAME
m=$GIT_AUTHOR_EMAIL

case ${GIT_AUTHOR_NAME} in
        "a_kovalchuk") n="Anton Kovalchuk" ; m="anton.kovalchuk@volia-software.com" ;;
        "danko") n="Vladislav Danko" ; m="vladislav.danko@volia-software.com" ;;
        "dtkachuk") n="Darya Tkachuk" ; m="darya.tkachuk@volia-software.com" ;;
        "karpyuk") n="Yurij Karpyuk" ; m="yurij.karpyuk@volia-software.com" ;;
        "kashperuk") n="Oleh Kashperuk" ; m="oleh.kashperuk@volia-software.com" ;;
        "michael.naumov") n="Michael Naumov" ; m="michael.naumov@volia-software.com" ;;
        "mopan") n="Alex Mopan" ; m="alex.mopan@volia-software.com" ;;
        "obrzut") n="Vince Obrzut" ; m="vinceo@risc-inc.com" ;;
        "oleh.yakobchuk") n="Oleh Yakobchuk" ; m="oleh.yakobchuk@volia-software.com" ;;
        "p_kvitko") n="Pavlo Kvitko" ; m="pavlo.kvitko@volia-software.com" ;;
        "prokhorov") n="Andreii Prokhorov" ; m="andreii.prokhorov@volia-software.com" ;;
        "ralchenko") n="Victor Ralchenko" ; m="victor.ralchenko@volia-software.com" ;;
        "riscbuilder") n="RISCBuilder" ; m="riscbuilder@volia-software.com" ;;
        "sergey.hurko") n="Sergey Hurko" ; m="sergey.hurko@volia-software.com" ;;
        "sharunovych") n="Vladimir Sharunovych" ; m="vladimir.sharunovych@volia-software.com" ;;
        "shurko") n="Sergey Hurko" ; m="sergey.hurko@volia-software.com" ;;
        "skibinskaya") n="Tatiana Skibinskaya" ; m="tatiana.skibinskaya@volia-software.com" ;;
        "stkachuk") n="Alexander Tkachuk" ; m="alexander.tkachuk@volia-software.com" ;;
        "vladislav.danko") n="Vladislav Danko" ; m="vladislav.danko@volia-software.com" ;;
        "yakobchuk") n="Oleh Yakobchuk" ; m="oleh.yakobchuk@volia-software.com" ;;
        "Yuriy.karpyuk") n="Yurij Karpyuk" ; m="yurij.karpyuk@volia-software.com" ;;
esac

export GIT_AUTHOR_NAME="$n"
export GIT_AUTHOR_EMAIL="$m"
export GIT_COMMITTER_NAME="$n"
export GIT_COMMITTER_EMAIL="$m"