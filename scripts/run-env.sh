# File: run-env.sh
# This file will be automagically sourced by run-java.sh

# NON-HEAP memory definition
# Metaspace size limit
MAX_METASPACE="-XX:MaxMetaspaceSize=128m"

# Compressed class space size limit
COMPRESSED_CLASS_SPACE="-XX:CompressedClassSpaceSize=64m"

# Code cache size for JIT-compiled code
CODE_CACHE_SIZE="-XX:ReservedCodeCacheSize=64m"

# Thread stack size
THREAD_STACK_SIZE="-Xss1m"

# Direct memory size limit
MAX_DIRECT_MEMORY_SIZE="-XX:MaxDirectMemorySize=256m"

# HEAP Memory ratio configurations
JAVA_MAX_MEM_RATIO=75  # 75% of available memory for maximum heap
JAVA_INIT_MEM_RATIO=25 # 25% of available memory for initial heap

# Combine individual options into JAVA_OPTIONS
JAVA_OPTIONS="$MAX_METASPACE $COMPRESSED_CLASS_SPACE $CODE_CACHE_SIZE $THREAD_STACK_SIZE $MAX_DIRECT_MEMORY_SIZE"

# Please refer to all options below

# JAVA_APP_DIR:
# The directory where the application resides. All paths in your application
# are relative to this directory. By default, it is the same directory where this
# startup script is located.

# JAVA_LIB_DIR:
# Directory holding the Java JAR files and an optional `classpath` file
# that specifies the classpath. The classpath file can either contain a
# single line with colon-separated paths or list jar files line-by-line.
# If not set, JAVA_LIB_DIR defaults to JAVA_APP_DIR.

# JAVA_OPTIONS:
# Additional JVM options to pass when running the Java application.

# JAVA_MAJOR_VERSION:
# Specifies the Java version number (e.g., 7, 8, 11). If set, options
# unsuitable for the given version will be removed. For versions >= 10,
# memory limits are automatically handled by the JVM, so explicit memory
# settings are omitted.

# JAVA_MAX_MEM_RATIO:
# Specifies the maximum heap memory as a percentage of container memory.
# Default is 25% if memory is below 300MB, or 50% otherwise. Set to 0
# to disable automatic `-Xmx` calculation. Ignored if no memory limit is set.

# JAVA_INIT_MEM_RATIO:
# Specifies the initial heap memory as a percentage of container memory,
# effective if no `-Xms` option is specified. Ignored if no memory limit is set.

# JAVA_MAX_CORE:
# Restricts the number of cores available to the JVM for tuning defaults
# like garbage collection threads. Set to 0 to disable core-based tuning.

# JAVA_DIAGNOSTICS:
# Enables diagnostic information output when this variable is set.

# JAVA_MAIN_CLASS:
# The main class to be used as an argument for `java`. When set, all jar
# files in JAVA_APP_DIR and JAVA_LIB_DIR are added to the classpath.

# JAVA_APP_JAR:
# Specifies the main application jar file. If no `JAVA_MAIN_CLASS` is set,
# this JAR file can be executed directly with `java -jar`. The jar is
# always added to the classpath.

# JAVA_APP_NAME:
# The name to use for the process.

# JAVA_CLASSPATH:
# Custom classpath for the application. If not set, the script checks for
# a `${JAVA_APP_DIR}/classpath` file. If missing, all jars in JAVA_APP_DIR
# are added by default.

# JAVA_DEBUG:
# Enables remote debugging when set.

# JAVA_DEBUG_SUSPEND:
# Enables suspend mode in remote debugging, pausing execution until a
# debugger attaches.

# JAVA_DEBUG_PORT:
# The port to use for remote debugging. Defaults to 5005.

# HTTP_PROXY:
# URL of the proxy server for HTTP, setting `http.proxyHost` and `http.proxyPort`.

# HTTPS_PROXY:
# URL of the proxy server for HTTPS, setting `https.proxyHost` and `https.proxyPort`.

# no_proxy, NO_PROXY:
# Comma-separated list of hosts to bypass the proxy, setting `http.nonProxyHosts`.

# HIDE_CMD_LINE:
# When set to `1` or `true`, hides the full command line used to start
# the Java application.




