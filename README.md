# TbDD-AIC: Enhanced Seismological b-Value Calculation Tool

TbDD-AIC is a powerful Matlab tool for calculating b-values in seismology, employing advanced data-driven techniques and Akaice Information Criterion (AIC) values for optimized model selection. Through parallel computation, it significantly enhances processing speed, enabling seismologists to analyze seismic events and assess seismic hazards with greater accuracy.

About the TbDD-AIC Method:
In seismology, the b-value plays a pivotal role in the analysis of the Magnitude-Frequency Distribution (MFD) of seismic events and seismic hazard assessment. However, the conventional method for computing time-varying b-values involves sliding a fixed-size window with a predetermined number of events and step size. We introduce the TbDD-AIC method, which leverages Akaice Information Criterion (AIC) values for model selection, showing promising performance in objectively establishing computation rules and accurately identifying abrupt changes in b-values.

Key Advantages:
Utilizes advanced data-driven techniques for more precise b-value calculations.
Significantly improves computation speed through parallel processing.
Accurately identifies abrupt changes in b-values.
Requirements:
To ensure smooth program execution, it is recommended to install a higher version of Matlab.

Test Data:
We provide two sets of test data for the TbDD-AIC program:
Real seismic sequence data, including the 2021 MS6.4 Yangbi earthquake sequence in Yunnan, China.
Synthetic theoretical seismic catalogs, encompassing theoretical seismic catalogs with different magnitude-frequency relationship (MFD) parameters for eight different time periods, which can be used to assess the stability and accuracy of the TbDD-AIC method.

Citation:
If you use this program for scientific research and intend to publish your findings, we recommend citing the following two papers to express gratitude and support:

Yin, F. L., Jiang, C. S., 2023. An improved study of the time series b-value calculation method based on data-driven approach. Geophysical Journal International, submitted.
Jiang C., Jiang C. S., Yin F. L., et al., 2021a. A new method for calculating b-value of time sequence based on data-driven (TbDD): A case study of the 2021 Yangbi MS6.4 earthquake sequence in Yunnan. Chinese Journal of Geophysics (in Chinese), 64(9): 3126-3134, doi: 10.6038/cjg2021P0385.