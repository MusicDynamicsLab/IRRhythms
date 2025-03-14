This repository includes the MATLAB code for the manuscript "Musical rhythm categorization is predicted by neural oscillation and Hebbian learning".

Before running the code
* Download or clone the GrFNN Toolbox (https://github.com/MusicDynamicsLab/GrFNNToolbox) and add its foloders to the MATLAB path
* Change the working directory to the base directory of the repository (IRRhythms)
* Add the 'Overrides' folder to the path
* Create the following empty folders in the base folder of the repository (they will be used to save data files)
  - Experiment 1
  - Experiment 2
  - Experiment 2a
  - LearnedRhythms1
  - LearnedRhythms1a
  - LearnedRhythms2
  - LearnedRhythms2a

To run the experiments in the manuscript, please follow the instructions below.

# Experiment 1
* Train the model by running **learnRhythms.m** (set `MODEL = 'MODEL1';` in line 10)
* Run the experiment by running **runExperiment.m** (set `MODEL = 'MODEL1';` in line 10)
* Calculate stats and plot results by running **PlottingAndStatisticalCalculationFinal.m** (specify the data file to use at the top of the code*)

# Experiment 1A
* Train the model by running **learnRhythms.m** (set `MODEL = 'MODEL1a';` in line 10)
* Plot results by running **plotRhythmsContinuum.m**

# Experiment 2
* Train the model by running **learnRhythms.m** (set `MODEL = 'MODEL2';` in line 10)
* Run the experiment by running **runExperiment.m** (set `MODEL = 'MODEL2';` in line 10)
* Calculate stats and plot results by running **PlottingAndStatisticalCalculationFinal.m** (specify the data file to use at the top of the code*)

# Experiment 2A
* Train the model by running **learnRhythms.m** (set `MODEL = 'MODEL2a';` in line 10)
* Run the experiment by running **runExperiment.m** (set `MODEL = 'MODEL2a';` in line 10)
* Calculate stats and plot results by running **PlottingAndStatisticalCalculationFinal.m** (specify the data file to use at the top of the code*)

\* You can use either the data that you generated by running the code (saved in the 'Experiment' folders) or the data that are included in the 'PublishedResults' folder (obtained by the authors and used in the manuscript).
