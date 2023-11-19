# TbDD-AIC: Enhanced Seismological b-Value Calculation Tool

TbDD-AIC is a powerful Matlab tool for calculating b-values in seismology, employing advanced data-driven techniques and Akaice Information Criterion (AIC) values for optimized model selection. Through parallel computation, it significantly enhances processing speed, enabling seismologists to analyze seismic events and assess seismic hazards with greater accuracy.

About the TbDD-AIC Method:
In seismology, the b-value plays a pivotal role in the analysis of the Magnitude-Frequency Distribution (MFD) of seismic events and seismic hazard assessment. However, the conventional method for computing time-varying b-values involves sliding a fixed-size window with a predetermined number of events and step size. We introduce the TbDD-AIC method, which leverages Akaike Information Criterion (AIC) values for model selection, showing promising performance in objectively establishing computation rules and accurately identifying abrupt changes in b-values.

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

Yin, F. L., Jiang, C. S., 2023. An improved study of the time series b-value calculation method based on data-driven approach. Geophysical Journal International, 236(1): 78-87. https://doi.org/10.1093/gji/ggad419.

Jiang C., Jiang C. S., Yin F. L., et al., 2021. A new method for calculating b-value of time sequence based on data-driven (TbDD): A case study of the 2021 Yangbi MS6.4 earthquake sequence in Yunnan. Chinese Journal of Geophysics (in Chinese), 64(9): 3126-3134, doi: 10.6038/cjg2021P0385.

Si, Z. Y., Jiang, C. S., 2019. Research on parameters calculation of the Ogata-Katsura 1993 model in frequency-magnitude distribution based on data-driven approach. Seismological Research Letters, 90 (3): 1318-1329. https://doi.org/10.1785/0220180372.

Jiang, C. S., Han, L. B., Long, F., et al., 2021. Spatiotemporal heterogeneity of b values revealed by a data-driven approach for June 17, 2019 Ms 6.0, Changning Sichuan, China earthquake sequence, Natural Hazards and Earth System Sciences, 21: 2233-2244, https://doi.org/10.5194/nhess-21-2233-2021.
