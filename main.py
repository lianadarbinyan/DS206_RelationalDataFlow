import sys
import os
#from pipeline_relational_data.flow import RelationalDataFlow
from pipeline_dimensional_data.flow import DimensionalDataFlow
if __name__ == "__main__":
    # Instantiate the RelationalDataFlow class and execute the flow
    flow_instance = DimensionalDataFlow()
    
    flow_instance.exec()


