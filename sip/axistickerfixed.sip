/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPAxisTickerFixed : public QCPAxisTicker
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum ScaleStrategy { ssNone      ///< Modifications are not allowed, the specified tick step is absolutely fixed. This might cause a high tick density and overlapping labels if the axis range is zoomed out.
                       ,ssMultiples ///< An integer multiple of the specified tick step is allowed. The used factor follows the base class properties of \ref setTickStepStrategy and \ref setTickCount.
                       ,ssPowers    ///< An integer power of the specified tick step is allowed.
                     };
  
  QCPAxisTickerFixed();
  
  // getters:
  double tickStep() const;
  ScaleStrategy scaleStrategy();
  
  // setters:
  void setTickStep(double step);
  void setScaleStrategy(ScaleStrategy strategy);

protected:
  // reimplemented virtual methods:
  virtual double getTickStep(const QCPRange &range);
};
