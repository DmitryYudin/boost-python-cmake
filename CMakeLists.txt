cmake_minimum_required(VERSION 3.5)
project(hello_ext)

find_package(Python3 REQUIRED COMPONENTS Development NumPy)
find_package(Boost REQUIRED COMPONENTS system python)

add_library(${PROJECT_NAME} MODULE src/hello.cpp) # ~= SHARED
target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES})
target_link_libraries(${PROJECT_NAME} Python3::Python Python3::NumPy)

set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "") # Suppress 'lib' prefix

configure_file(test/test.py . COPYONLY)

install(TARGETS ${PROJECT_NAME}
    ARCHIVE DESTINATION ${PROJECT_NAME}
    LIBRARY DESTINATION ${PROJECT_NAME}
)
install(FILES src/__init__.py DESTINATION ${PROJECT_NAME})
install(DIRECTORY test/ DESTINATION .
    FILES_MATCHING 
    PATTERN "*.py" PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
    PATTERN "__init__.py" EXCLUDE
)
