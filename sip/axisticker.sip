/** PyQt5 binding for QCustomPlot v2.0.0
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
#include <QCustomPlot/src/qcp.h>
%End

%ConvertToSubClassCode
  QCPAxisTicker* ticker = dynamic_cast<QCPAxisTicker*>(sipCpp);
  sipType = 0;
  if (ticker) {
    if (dynamic_cast<QCPAxisTickerDateTime*>(ticker) != 0)
      sipType = sipType_QCPAxisTickerDateTime;
    else if (dynamic_cast<QCPAxisTickerFixed*>(ticker) != 0)
      sipType = sipType_QCPAxisTickerFixed;
    else if (dynamic_cast<QCPAxisTickerLog*>(ticker) != 0)
      sipType = sipType_QCPAxisTickerLog;
    else if (dynamic_cast<QCPAxisTickerPi*>(ticker) != 0)
      sipType = sipType_QCPAxisTickerPi;
    else if (dynamic_cast<QCPAxisTickerText*>(ticker) != 0)
      sipType = sipType_QCPAxisTickerText;
    else if (dynamic_cast<QCPAxisTickerTime*>(ticker) != 0)
      sipType = sipType_QCPAxisTickerTime;
  }
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

private:
  QCPAxisTicker(const QCPAxisTicker&);
  QCPAxisTicker& operator=(const QCPAxisTicker&);
};
