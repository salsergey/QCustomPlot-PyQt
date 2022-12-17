/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPAxisTicker
{
%TypeHeaderCode
#include <qcustomplot.h>
%End

%ConvertToSubClassCode
  sipType = 0;
  if (dynamic_cast<QCPAxisTickerDateTime*>(sipCpp) != 0)
    sipType = sipType_QCPAxisTickerDateTime;
  else if (dynamic_cast<QCPAxisTickerFixed*>(sipCpp) != 0)
    sipType = sipType_QCPAxisTickerFixed;
  else if (dynamic_cast<QCPAxisTickerLog*>(sipCpp) != 0)
    sipType = sipType_QCPAxisTickerLog;
  else if (dynamic_cast<QCPAxisTickerPi*>(sipCpp) != 0)
    sipType = sipType_QCPAxisTickerPi;
  else if (dynamic_cast<QCPAxisTickerText*>(sipCpp) != 0)
    sipType = sipType_QCPAxisTickerText;
  else if (dynamic_cast<QCPAxisTickerTime*>(sipCpp) != 0)
    sipType = sipType_QCPAxisTickerTime;
%End

public:
  enum TickStepStrategy
  {
    tssReadability    ///< A nicely readable tick step is prioritized over matching the requested number of ticks (see \ref setTickCount)
    ,tssMeetTickCount ///< Less readable tick steps are allowed which in turn facilitates getting closer to the requested tick count
  };

  QCPAxisTicker();
  virtual ~QCPAxisTicker();

  // getters:
  TickStepStrategy tickStepStrategy() const;
  int tickCount() const;
  double tickOrigin() const;

  // setters:
  void setTickStepStrategy(TickStepStrategy strategy);
  void setTickCount(int count);
  void setTickOrigin(double origin);

  // introduced virtual methods:
  virtual void generate(const QCPRange &range, const QLocale &locale, QChar formatChar, int precision, QVector<double> &ticks, QVector<double> *subTicks, QVector<QString> *tickLabels);

protected:
  // introduced virtual methods:
  virtual double getTickStep(const QCPRange &range);
  virtual int getSubTickCount(double tickStep);
  virtual QString getTickLabel(double tick, const QLocale &locale, QChar formatChar, int precision);
  virtual QVector<double> createTickVector(double tickStep, const QCPRange &range);
  virtual QVector<double> createSubTickVector(int subTickCount, const QVector<double> &ticks);
  virtual QVector<QString> createLabelVector(const QVector<double> &ticks, const QLocale &locale, QChar formatChar, int precision);

  // non-virtual methods:
  void trimTicks(const QCPRange &range, QVector<double> &ticks, bool keepOneOutlier) const;
  double pickClosest(double target, const QVector<double> &candidates) const;
  double getMantissa(double input, double *magnitude=0) const;
  double cleanMantissa(double input) const;

private:
  QCPAxisTicker(const QCPAxisTicker&);
  QCPAxisTicker& operator=(const QCPAxisTicker&);
};
